import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bussin/data/models/favorite_stop.dart';
import 'package:bussin/data/repositories/favorites_repository.dart';

/// ---------------------------------------------------------------------------
/// Favorites Providers
/// ---------------------------------------------------------------------------
/// These providers manage the user's favorite transit stops. Favorites
/// are persisted in the local SQLite database and loaded into memory
/// via an AsyncNotifier. The UI can add/remove favorites and check
/// whether a specific stop is favorited.
/// ---------------------------------------------------------------------------

/// Singleton instance of [FavoritesRepository].
///
/// Provides CRUD operations on the favorites SQLite table.
final favoritesRepositoryProvider = Provider<FavoritesRepository>((ref) {
  return FavoritesRepository();
});

/// Manages the list of favorite stops with async persistence.
///
/// Uses [AsyncNotifier] to load favorites from SQLite on initialization
/// and exposes methods to add/remove favorites that update both the
/// database and the in-memory state.
///
/// Widgets watch this provider to display the favorites list and
/// react to add/remove operations immediately.
final favoritesProvider =
    AsyncNotifierProvider<FavoritesNotifier, List<FavoriteStop>>(
  FavoritesNotifier.new,
);

/// Notifier that manages favorite stop state with SQLite persistence.
///
/// The [build] method loads all favorites from the database on first access.
/// Mutation methods ([addFavorite], [removeFavorite]) update the database
/// first, then refresh the in-memory state to keep the UI synchronized.
class FavoritesNotifier extends AsyncNotifier<List<FavoriteStop>> {
  /// Loads all favorite stops from SQLite, ordered by most recently added.
  @override
  Future<List<FavoriteStop>> build() async {
    final repo = ref.read(favoritesRepositoryProvider);
    return repo.getFavorites();
  }

  /// Adds a stop to favorites and refreshes the state.
  ///
  /// Inserts the stop into SQLite, then reloads the full favorites list
  /// to ensure the UI is in sync with the database.
  Future<void> addFavorite(FavoriteStop stop) async {
    final repo = ref.read(favoritesRepositoryProvider);
    await repo.addFavorite(stop);

    // Reload from database to ensure consistency
    state = AsyncData(await repo.getFavorites());
  }

  /// Removes a stop from favorites by its stop ID and refreshes the state.
  ///
  /// Deletes the stop from SQLite, then reloads the full favorites list.
  Future<void> removeFavorite(String stopId) async {
    final repo = ref.read(favoritesRepositoryProvider);
    await repo.removeFavorite(stopId);

    // Reload from database to ensure consistency
    state = AsyncData(await repo.getFavorites());
  }
}

/// Checks whether a specific stop is in the user's favorites.
///
/// Derived from [favoritesProvider] -- compares the given [stopId]
/// against the list of favorited stop IDs. Returns false while
/// the favorites list is loading or on error.
final isFavoriteProvider =
    Provider.family<bool, String>((ref, stopId) {
  final favorites = ref.watch(favoritesProvider);

  return favorites.when(
    data: (list) => list.any((fav) => fav.stopId == stopId),
    loading: () => false,
    error: (_, __) => false,
  );
});
