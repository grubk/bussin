import 'package:intl/intl.dart';

/// Time and ETA formatting utilities for transit arrival predictions.
/// Handles countdown formatting, delay indicators, and schedule times.
class TimeUtils {
  TimeUtils._();

  /// Formats a number of seconds until arrival into a readable ETA string.
  ///
  /// Returns contextual strings like "Now", "< 1 min", "2 min", "15 min".
  static String formatEta(int secondsAway) {
    if (secondsAway <= 30) return 'Now';
    if (secondsAway < 60) return '< 1 min';
    final minutes = (secondsAway / 60).round();
    return '$minutes min';
  }

  /// Formats a timestamp into a relative "time ago" string.
  ///
  /// Returns strings like "Just now", "3 min ago", "1 hr ago".
  static String timeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final diff = now.difference(timestamp);

    if (diff.inSeconds < 30) return 'Just now';
    if (diff.inMinutes < 1) return '${diff.inSeconds}s ago';
    if (diff.inHours < 1) return '${diff.inMinutes} min ago';
    if (diff.inDays < 1) return '${diff.inHours} hr ago';
    return '${diff.inDays}d ago';
  }

  /// Formats a DateTime to a 12-hour time string like "3:45 PM".
  ///
  /// Uses the intl package for locale-aware formatting.
  static String formatScheduledTime(DateTime time) {
    return DateFormat('h:mm a').format(time);
  }

  /// Formats a delay in seconds into a human-readable delay indicator.
  ///
  /// Returns "+3 min late", "-1 min early", or "On time" for zero delay.
  static String formatDelay(int delaySeconds) {
    if (delaySeconds == 0) return 'On time';

    final minutes = (delaySeconds.abs() / 60).round();
    if (minutes == 0) return 'On time';

    if (delaySeconds > 0) {
      return '+$minutes min late';
    }
    return '-$minutes min early';
  }
}
