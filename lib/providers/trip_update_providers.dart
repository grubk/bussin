import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:bussin/core/constants/api_constants.dart';
import 'package:bussin/data/datasources/translink_api_service.dart';
import 'package:bussin/data/models/trip_update.dart';
import 'package:bussin/data/repositories/trip_update_repository.dart';
import 'package:bussin/providers/vehicle_providers.dart';
import 'package:bussin/providers/route_providers.dart';

/// ---------------------------------------------------------------------------
/// Trip Update Providers
/// ---------------------------------------------------------------------------
/// These providers expose real-time trip update / ETA data from TransLink's
/// GTFS-RT V3 trip updates endpoint. Polled every 30 seconds. Derived
/// providers filter ETAs by stop ID or look up a single trip's update.
/// ---------------------------------------------------------------------------

/// Singleton instance of [TripUpdateRepository].
///
/// Reuses the shared [TranslinkApiService] from [translinkApiServiceProvider]
/// to avoid creating duplicate HTTP clients. Also injects [LocalDatabaseService]
/// to resolve missing stop IDs in GTFS-RT trip updates.
final tripUpdateRepositoryProvider = Provider<TripUpdateRepository>((ref) {
  final apiService = ref.watch(translinkApiServiceProvider);
  final dbService = ref.watch(localDatabaseServiceProvider);
  return TripUpdateRepository(
    apiService: apiService,
    dbService: dbService,
  );
});

/// Stream of all trip updates, polling every 30 seconds.
///
/// Each emission contains the full list of [TripUpdateModel] from all
/// active trips. Trip updates include per-stop arrival/departure predictions
/// with delay information, enabling real-time ETA displays.
///
/// Auto-disposes when no widget is watching.
final tripUpdatesProvider =
    StreamProvider.autoDispose<List<TripUpdateModel>>((ref) async* {
  while (true) {
    yield await ref.read(tripUpdateRepositoryProvider).getTripUpdates();
    await Future.delayed(ApiConstants.tripUpdatePollInterval);
  }
});

/// ETAs for a specific stop, derived from the trip updates stream.
///
/// Filters all [StopTimeUpdateModel] entries across all trip updates
/// that match the given [stopId], then sorts by predicted arrival time
/// ascending (soonest first).
///
/// Returns [AsyncValue<List<StopTimeUpdateModel>>] so widgets can handle
/// loading/error states gracefully.
final etasForStopProvider = Provider.autoDispose
    .family<AsyncValue<List<StopTimeUpdateModel>>, String>((ref, stopId) {
  final updates = ref.watch(tripUpdatesProvider);

  return updates.whenData((allUpdates) {
    debugPrint('[ETAs] Filtering for stopId="$stopId", have ${allUpdates.length} trip updates');
    
    // Collect all stop time updates matching this stop ID
    final etas = <StopTimeUpdateModel>[];
    int totalStopsChecked = 0;
    
    for (final update in allUpdates) {
      for (final stopTime in update.stopTimeUpdates) {
        totalStopsChecked++;
        if (stopTime.stopId == stopId) {
          etas.add(stopTime);
        }
      }
    }

    debugPrint('[ETAs] Checked $totalStopsChecked stops, found ${etas.length} matches');
    
    if (etas.isEmpty && allUpdates.isNotEmpty) {
      // Sample a few stop IDs to see what we have
      final samples = allUpdates
          .take(3)
          .expand((u) => u.stopTimeUpdates.take(2))
          .map((s) => '"${s.stopId}"')
          .take(6)
          .join(', ');
      debugPrint('[ETAs] Sample stopIds in feed: $samples');
    }

    // Sort by predicted arrival time (earliest first)
    etas.sort((a, b) {
      final aTime = a.predictedArrival;
      final bTime = b.predictedArrival;
      if (aTime == null && bTime == null) return 0;
      if (aTime == null) return 1;
      if (bTime == null) return -1;
      return aTime.compareTo(bTime);
    });

    return etas;
  });
});

/// Single trip update lookup by trip ID.
///
/// Returns the [TripUpdateModel] for the given [tripId], or null if
/// no update exists (e.g., the trip has completed or hasn't started).
/// Derives from [tripUpdatesProvider] to avoid extra API calls.
final tripUpdateProvider = Provider.autoDispose
    .family<AsyncValue<TripUpdateModel?>, String>((ref, tripId) {
  final updates = ref.watch(tripUpdatesProvider);

  return updates.whenData((allUpdates) {
    try {
      return allUpdates.firstWhere((u) => u.tripId == tripId);
    } catch (_) {
      return null;
    }
  });
});
