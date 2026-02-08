/// Custom exception classes thrown by datasource layer.
/// Each exception type maps to a specific failure mode for clear error handling.

/// Thrown when an HTTP request to the TransLink API fails.
class ServerException implements Exception {
  /// Human-readable error message.
  final String message;

  /// HTTP status code from the failed response, if available.
  final int? statusCode;

  const ServerException({required this.message, this.statusCode});

  @override
  String toString() => 'ServerException: $message (status: $statusCode)';
}

/// Thrown when a SQLite database read/write operation fails.
class CacheException implements Exception {
  final String message;

  const CacheException({required this.message});

  @override
  String toString() => 'CacheException: $message';
}

/// Thrown when GPS location is unavailable or permission is denied.
class LocationException implements Exception {
  final String message;

  const LocationException({required this.message});

  @override
  String toString() => 'LocationException: $message';
}

/// Thrown when protobuf or CSV data parsing fails.
class ParseException implements Exception {
  final String message;

  const ParseException({required this.message});

  @override
  String toString() => 'ParseException: $message';
}
