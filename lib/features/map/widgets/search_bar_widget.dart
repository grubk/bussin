import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bussin/navigation/app_router.dart';

/// ---------------------------------------------------------------------------
/// SearchBarWidget - Frosted glass search bar overlay on the map
/// ---------------------------------------------------------------------------
/// A read-only search bar that sits at the top of the map screen with a
/// frosted glass (blur) background. This is NOT an active text input on
/// the map screen -- it serves as a visual tap target that navigates to
/// the full SearchScreen when tapped.
///
/// Design rationale:
/// - The search bar on the map is intentionally read-only to prevent the
///   keyboard from obscuring the map view
/// - Tapping it navigates to a dedicated full-screen search experience
///   (SearchScreen) where the user can type freely
/// - The frosted glass effect (BackdropFilter) blurs the map content
///   beneath the search bar for readability while maintaining the
///   immersive full-screen map feel
///
/// Styling:
/// - CupertinoSearchTextField appearance (iOS-native look)
/// - Rounded corners with shadow for depth
/// - Horizontal padding from screen edges
/// - Placeholder text: "Search routes or stops..."
///
/// This is a [ConsumerWidget] for consistency with the Riverpod architecture,
/// though it currently doesn't read any providers. Future enhancements could
/// display the last search query text here.
/// ---------------------------------------------------------------------------
class SearchBarWidget extends ConsumerWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
      // Rounded corners for the frosted glass container
      borderRadius: BorderRadius.circular(12),

      child: BackdropFilter(
        // --- Frosted glass blur effect ---
        // Blurs the map content underneath with a 10px gaussian blur.
        // This creates the "frosted glass" aesthetic that's signature
        // to iOS/Cupertino design.
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),

        child: Container(
          // Semi-transparent background tinted with the system background color.
          // Combined with the blur, this creates the frosted glass look.
          decoration: BoxDecoration(
            color: CupertinoColors.systemBackground.withOpacity(0.7),
            borderRadius: BorderRadius.circular(12),
            // Subtle shadow for depth and separation from the map
            boxShadow: [
              BoxShadow(
                color: CupertinoColors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),

          child: GestureDetector(
            // --- Navigate to SearchScreen on tap ---
            // The entire search bar is a tap target. When tapped, it pushes
            // the SearchScreen onto the navigation stack where the user
            // can type a query with a real keyboard.
            onTap: () => AppRouter.pushSearch(context),

            // AbsorbPointer prevents the CupertinoSearchTextField from
            // receiving focus/input events. We only want the tap gesture
            // to be handled by the GestureDetector above.
            child: const AbsorbPointer(
              child: CupertinoSearchTextField(
                // Placeholder text guides the user on what they can search for
                placeholder: 'Search routes or stops...',

                // Disable the text field visually but keep its appearance.
                // The enabled: false approach doesn't style correctly in
                // Cupertino, so we use AbsorbPointer instead.
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
