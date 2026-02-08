import 'dart:async';
import 'package:flutter/foundation.dart';

/// Debounces rapid function calls to prevent excessive execution.
///
/// Commonly used for search input to avoid querying the database
/// on every keystroke. Only the last call within the debounce window executes.
class Debouncer {
  /// Delay in milliseconds before executing the debounced action.
  final int milliseconds;

  /// Internal timer tracking the debounce window.
  Timer? _timer;

  /// Creates a Debouncer with the specified delay.
  ///
  /// [milliseconds] defaults to 300ms, suitable for search input debouncing.
  Debouncer({this.milliseconds = 300});

  /// Schedules [action] to run after the debounce delay.
  ///
  /// If called again before the delay expires, the previous pending action
  /// is cancelled and a new timer starts.
  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  /// Cancels any pending debounced action without executing it.
  void cancel() {
    _timer?.cancel();
  }

  /// Disposes of the debouncer by cancelling any pending timer.
  /// Should be called when the widget using this debouncer is disposed.
  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}
