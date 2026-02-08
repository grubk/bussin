import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import 'package:bussin/core/constants/app_constants.dart';
import 'package:bussin/data/models/vehicle_position.dart';

/// ---------------------------------------------------------------------------
/// BusMarkerLayer - Renders animated bus markers on the map
/// ---------------------------------------------------------------------------
/// Displays one marker per active bus vehicle from the real-time GTFS-RT feed.
/// Each marker shows:
/// - A colored container with the route number text
/// - Rotated to match the vehicle's bearing (heading direction)
///
/// Smooth animation:
/// - Stores previous positions in a Map<vehicleId, LatLng>
/// - When new positions arrive from polling, uses an AnimationController
///   (2 second duration) to interpolate (lerp) between old and new positions
/// - This creates the visual effect of buses gliding smoothly rather than
///   teleporting on each 10-second poll update
///
/// Uses [ConsumerStatefulWidget] with [TickerProviderStateMixin] because:
/// - AnimationController requires a TickerProvider (vsync)
/// - State must persist across rebuilds to track previous positions
///
/// Props:
/// - [vehicles]: Current list of vehicle positions from the provider
/// - [onBusTapped]: Callback when user taps a bus marker
/// ---------------------------------------------------------------------------
class BusMarkerLayer extends ConsumerStatefulWidget {
  /// List of current vehicle positions to render as markers.
  final List<VehiclePositionModel> vehicles;

  /// Callback invoked with the vehicle data when a marker is tapped.
  /// Typically opens the BusInfoBottomSheet.
  final void Function(VehiclePositionModel vehicle) onBusTapped;

  const BusMarkerLayer({
    super.key,
    required this.vehicles,
    required this.onBusTapped,
  });

  @override
  ConsumerState<BusMarkerLayer> createState() => _BusMarkerLayerState();
}

class _BusMarkerLayerState extends ConsumerState<BusMarkerLayer>
    with TickerProviderStateMixin {
  /// Stores the previous position for each vehicle (keyed by vehicleId).
  /// Used as the starting point for the lerp animation when a new position
  /// arrives from the polling stream.
  final Map<String, LatLng> _previousPositions = {};

  /// Stores the target (latest) position for each vehicle.
  /// This is the destination of the current animation.
  final Map<String, LatLng> _targetPositions = {};

  /// Stores the currently interpolated (animated) position for each vehicle.
  /// Updated on every animation tick and used for marker placement.
  final Map<String, LatLng> _animatedPositions = {};

  /// Single animation controller driving all marker animations.
  /// Runs from 0.0 to 1.0 over 2 seconds whenever new positions arrive.
  late AnimationController _animationController;

  /// Curved animation for smoother ease-out movement.
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Create the animation controller with the configured duration (2s).
    // This matches the AppConstants.markerAnimationDuration for consistency.
    _animationController = AnimationController(
      vsync: this,
      duration: AppConstants.markerAnimationDuration,
    );

    // Apply an ease-out curve so buses decelerate naturally at the end
    // of their movement, mimicking real-world deceleration.
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    // Listen to animation ticks to update interpolated positions
    _animationController.addListener(_onAnimationTick);

    // Initialize positions from the first set of vehicles
    _updatePositions(widget.vehicles);
  }

  @override
  void didUpdateWidget(covariant BusMarkerLayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    // When the vehicle list changes (new poll data arrived), kick off
    // a new animation from current positions to the new positions.
    if (widget.vehicles != oldWidget.vehicles) {
      _updatePositions(widget.vehicles);
    }
  }

  /// Updates the position maps and starts the lerp animation.
  ///
  /// For each vehicle:
  /// 1. Save the current animated position (or current real position) as
  ///    the "previous" position (animation start point)
  /// 2. Store the new real position as the "target" (animation end point)
  /// 3. Reset and start the animation controller
  void _updatePositions(List<VehiclePositionModel> vehicles) {
    for (final vehicle in vehicles) {
      final newPos = LatLng(vehicle.latitude, vehicle.longitude);

      // Use the currently animated position as the start, falling back
      // to the new position if this is the first time we see this vehicle
      // (no animation for initial appearance).
      _previousPositions[vehicle.vehicleId] =
          _animatedPositions[vehicle.vehicleId] ?? newPos;
      _targetPositions[vehicle.vehicleId] = newPos;
    }

    // Remove entries for vehicles that are no longer in the list
    // (they've gone out of service or left the coverage area).
    final activeIds = vehicles.map((v) => v.vehicleId).toSet();
    _previousPositions.removeWhere((id, _) => !activeIds.contains(id));
    _targetPositions.removeWhere((id, _) => !activeIds.contains(id));
    _animatedPositions.removeWhere((id, _) => !activeIds.contains(id));

    // Reset and start the animation from 0.0 -> 1.0
    _animationController.forward(from: 0.0);
  }

  /// Called on every animation frame to interpolate positions.
  ///
  /// For each vehicle, linearly interpolates between the previous position
  /// and the target position using the current animation value (0.0 to 1.0).
  /// This creates smooth gliding movement on the map.
  void _onAnimationTick() {
    setState(() {
      final t = _animation.value;

      for (final vehicleId in _targetPositions.keys) {
        final start = _previousPositions[vehicleId];
        final end = _targetPositions[vehicleId];

        if (start != null && end != null) {
          // Linearly interpolate latitude and longitude independently
          _animatedPositions[vehicleId] = LatLng(
            start.latitude + (end.latitude - start.latitude) * t,
            start.longitude + (end.longitude - start.longitude) * t,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    // Clean up the animation controller to prevent memory leaks
    _animationController.removeListener(_onAnimationTick);
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Marker for each vehicle using the animated (interpolated) position.
    final markers = widget.vehicles.map((vehicle) {
      // Use the animated position if available, otherwise fall back to raw data
      final position = _animatedPositions[vehicle.vehicleId] ??
          LatLng(vehicle.latitude, vehicle.longitude);

      return Marker(
        // Position the marker at the interpolated lat/lng
        point: position,
        width: 40,
        height: 40,

        // The marker visual: a colored pill with route number, rotated by bearing
        child: GestureDetector(
          // Invoke the callback to open BusInfoBottomSheet
          onTap: () => widget.onBusTapped(vehicle),
          child: _BusMarkerIcon(
            routeId: vehicle.routeId,
            bearing: vehicle.bearing,
          ),
        ),
      );
    }).toList();

    // MarkerLayer renders all markers as a single layer on the map
    return MarkerLayer(markers: markers);
  }
}

/// ---------------------------------------------------------------------------
/// _BusMarkerIcon - Visual representation of a single bus marker
/// ---------------------------------------------------------------------------
/// A small rounded container showing the route number with:
/// - TransLink blue background (#0060A9)
/// - White text with the route number
/// - Rotation transform based on the vehicle's bearing (heading)
/// - Drop shadow for visibility against any map background
class _BusMarkerIcon extends StatelessWidget {
  /// Route ID to display on the marker (e.g., "049", "R4").
  final String routeId;

  /// Vehicle heading in degrees (0-360). Null if not reported.
  /// Used to rotate the marker to show direction of travel.
  final double? bearing;

  const _BusMarkerIcon({
    required this.routeId,
    this.bearing,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      // Convert bearing from degrees to radians for the transform.
      // Default to 0 (north-facing) if bearing is not available.
      angle: bearing != null ? bearing! * (math.pi / 180) : 0,
      child: Container(
        decoration: BoxDecoration(
          // TransLink blue brand color
          color: const Color(0xFF0060A9),
          borderRadius: BorderRadius.circular(8),
          // Drop shadow for visibility on both light and dark map areas
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.black.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          routeId,
          style: const TextStyle(
            color: CupertinoColors.white,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            // Prevent text from wrapping in the small container
            overflow: TextOverflow.ellipsis,
          ),
          maxLines: 1,
        ),
      ),
    );
  }
}
