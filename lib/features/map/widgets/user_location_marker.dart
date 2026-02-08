import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

/// ---------------------------------------------------------------------------
/// UserLocationMarker - Blue pulsing dot showing the user's GPS position
/// ---------------------------------------------------------------------------
/// Renders the user's current location on the map as:
/// - An outer ring: translucent blue (#007AFF at 30% opacity) that pulses
///   from 1.0x to 1.5x scale over 2 seconds in a repeating loop
/// - An inner dot: solid iOS blue (#007AFF), 12px diameter
///
/// The pulsing animation creates a "sonar" effect that draws the user's
/// attention to their location without being distracting.
///
/// When location is unavailable ([position] is null):
/// - Renders nothing (empty SizedBox), so the layer is invisible
///
/// Uses [StatefulWidget] (not Consumer) because:
/// - It doesn't read any providers directly (position is passed as a prop)
/// - It needs an AnimationController for the pulsing animation,
///   which requires TickerProviderStateMixin
/// ---------------------------------------------------------------------------
class UserLocationMarker extends StatefulWidget {
  /// The user's current GPS position, or null if unavailable.
  /// Null when location permission is denied or GPS is off.
  final Position? position;

  const UserLocationMarker({
    super.key,
    required this.position,
  });

  @override
  State<UserLocationMarker> createState() => _UserLocationMarkerState();
}

class _UserLocationMarkerState extends State<UserLocationMarker>
    with SingleTickerProviderStateMixin {
  /// Controls the pulsing animation for the outer ring.
  /// Repeats indefinitely from 0.0 to 1.0 over 2 seconds.
  late final AnimationController _pulseController;

  /// Tween animation that maps 0.0->1.0 to a scale of 1.0->1.5,
  /// creating the pulsing expansion effect on the outer ring.
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    // Create the animation controller with a 2-second period.
    // The reverse flag with repeat() creates a smooth pulse-in, pulse-out effect.
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Map the controller's 0.0-1.0 range to a 1.0-1.5 scale factor.
    // This means the outer ring grows to 150% of its base size at peak.
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.5,
    ).animate(
      CurvedAnimation(
        parent: _pulseController,
        // Ease in-out for smooth, natural-looking pulsing
        curve: Curves.easeInOut,
      ),
    );

    // Start the animation looping: forward (expand) then reverse (contract)
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    // Always dispose animation controllers to free system resources
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // --- Guard: location unavailable ---
    // Render nothing if we don't have the user's position.
    // This handles cases like permission denied, GPS off, or still loading.
    if (widget.position == null) {
      return const SizedBox.shrink();
    }

    // Convert the geolocator Position to latlong2 LatLng for FlutterMap
    final latLng = LatLng(
      widget.position!.latitude,
      widget.position!.longitude,
    );

    return MarkerLayer(
      markers: [
        Marker(
          point: latLng,
          width: 40,
          height: 40,
          child: _buildPulsingDot(),
        ),
      ],
    );
  }

  /// Builds the pulsing blue dot widget.
  ///
  /// Uses [AnimatedBuilder] to rebuild only the outer ring on each
  /// animation frame, keeping the inner dot static for performance.
  Widget _buildPulsingDot() {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // --- Outer ring: pulsing translucent blue circle ---
              // Scales from 1.0x to 1.5x using the animation value.
              // The opacity decreases as the ring expands, creating a
              // fading sonar-pulse effect.
              Transform.scale(
                scale: _pulseAnimation.value,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF007AFF).withOpacity(
                      // Fade opacity as the ring expands (1.0->0.3 at full scale)
                      0.3 / _pulseAnimation.value,
                    ),
                  ),
                ),
              ),

              // --- Inner dot: solid blue circle (static, no animation) ---
              // 12px diameter, iOS system blue (#007AFF).
              // White border provides contrast against any map background.
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF007AFF),
                  border: Border.all(
                    color: CupertinoColors.white,
                    width: 2,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
