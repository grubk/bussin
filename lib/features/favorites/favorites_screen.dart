import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bussin/providers/favorites_provider.dart';
import 'package:bussin/data/models/favorite_stop.dart';
import 'package:bussin/features/favorites/widgets/favorite_stop_tile.dart';

/// ---------------------------------------------------------------------------
/// FavoritesScreen - Bookmarked transit stops with live arrival data
/// ---------------------------------------------------------------------------
/// Displays the user's saved favorite stops in a scrollable list. Each stop
/// shows its name and upcoming bus arrivals (via [FavoriteStopTile]).
///
/// Features:
///   - Pulls favorites from [favoritesProvider] (AsyncNotifier backed by SQLite)
///   - Swipe-to-delete with Cupertino destructive action confirmation dialog
///   - Empty state when no favorites have been saved yet
///   - Loading and error states handled via AsyncValue pattern matching
///
/// Navigation: Accessible from the bottom navigation bar or via AppRouter.
/// ---------------------------------------------------------------------------
class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the favorites provider to reactively rebuild when favorites change.
    // This is an AsyncValue because favorites are loaded from SQLite.
    final favoritesAsync = ref.watch(favoritesProvider);

    return CupertinoPageScaffold(
      // --- Navigation bar with screen title ---
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Favorites'),
      ),

      // --- Main content: async state handling ---
      // Wrapped in Material to fix yellow underline text issues
      child: Material(
        type: MaterialType.transparency,
        child: SafeArea(
          child: favoritesAsync.when(
            // --- Loading state: show spinner while SQLite query completes ---
            loading: () => const Center(
              child: CupertinoActivityIndicator(),
            ),

            // --- Error state: display error message with retry info ---
            error: (error, stackTrace) => Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  'Failed to load favorites:\n$error',
                  textAlign: TextAlign.center,
                  // Removed 'const' because CupertinoColors.systemRed is dynamic
                  style: const TextStyle(
                    color: CupertinoColors.systemRed,
                    fontSize: 15,
                  ),
                ),
              ),
            ),

            // --- Data state: show the favorites list or empty state ---
            data: (favorites) {
              // Empty state when the user hasn't saved any favorite stops
              if (favorites.isEmpty) {
                return const _EmptyFavoritesView();
              }

              // Scrollable list of favorite stop tiles with swipe-to-delete
              return ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final favorite = favorites[index];
                  return FavoriteStopTile(
                    favorite: favorite,
                    // Callback triggered when the user confirms deletion
                    onDismissed: () => _confirmAndRemoveFavorite(
                      context,
                      ref,
                      favorite,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  /// Shows a Cupertino destructive action confirmation dialog before removing
  /// a favorite stop.
  ///
  /// Uses [showCupertinoDialog] with a destructive action button to match
  /// iOS conventions. Only removes the favorite if the user taps "Remove".
  void _confirmAndRemoveFavorite(
    BuildContext context,
    WidgetRef ref,
    FavoriteStop favorite,
  ) {
    showCupertinoDialog<void>(
      context: context,
      builder: (dialogContext) => CupertinoAlertDialog(
        title: const Text('Remove Favorite'),
        content: Text(
          'Are you sure you want to remove "${favorite.stopName}" from your favorites?',
        ),
        actions: [
          // Cancel button - dismisses the dialog without action
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(dialogContext).pop(),
          ),
          // Destructive remove button - deletes the favorite from SQLite
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('Remove'),
            onPressed: () {
              // Remove the favorite via the notifier (updates both DB and state)
              ref.read(favoritesProvider.notifier).removeFavorite(
                    favorite.stopId,
                  );
              Navigator.of(dialogContext).pop();
            },
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// _EmptyFavoritesView - Shown when the user has no saved favorites
/// ---------------------------------------------------------------------------
/// Provides a centered message with instructions on how to add favorites.
/// Uses the star icon to visually hint at the favoriting action.
class _EmptyFavoritesView extends StatelessWidget {
  const _EmptyFavoritesView();

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Star icon matching the favorite action icon used elsewhere
              // Removed 'const' because CupertinoColors.systemGrey3 is dynamic
              const Icon(
                CupertinoIcons.star,
                size: 48,
                color: CupertinoColors.systemGrey3,
              ),
              const SizedBox(height: 16),

              // Primary message
              // Removed 'const' because CupertinoColors.systemGrey is dynamic
              const Text(
                'No favorite stops yet',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: CupertinoColors.systemGrey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // Instructional sub-text
              // Removed 'const' because CupertinoColors.systemGrey2 is dynamic
              const Text(
                'Tap the star icon on a stop to add it here',
                style: TextStyle(
                  fontSize: 15,
                  color: CupertinoColors.systemGrey2,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
