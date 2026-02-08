import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:bussin/app.dart';
import 'package:bussin/data/datasources/local_database_service.dart';
import 'package:bussin/data/datasources/notification_service.dart';

/// ---------------------------------------------------------------------------
/// Main Entry Point
/// ---------------------------------------------------------------------------
/// Initializes essential services before launching the app:
///
/// 1. [WidgetsFlutterBinding.ensureInitialized] - Required before any async
///    work in main() so the Flutter engine is ready for platform channels.
///
/// 2. [LocalDatabaseService.init] - Opens/creates the SQLite database for
///    caching GTFS static data (routes, stops, shapes) and user data
///    (favorites, route history).
///
/// 3. [NotificationService.init] - Configures the local notifications plugin
///    and creates the Android notification channel for bus arrival alerts.
///
/// 4. [ProviderScope] - Wraps the app in Riverpod's dependency injection
///    container so all providers are accessible throughout the widget tree.
/// ---------------------------------------------------------------------------
void main() async {
  // Ensure Flutter bindings are initialized before calling async platform code
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the local SQLite database for GTFS data caching
  await LocalDatabaseService.init();

  // Initialize the notification plugin and create Android notification channel
  await NotificationService.init();

  // Launch the app wrapped in ProviderScope for Riverpod state management
  runApp(const ProviderScope(child: BussinApp()));
}
