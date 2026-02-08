/// Sealed class hierarchy representing handled failures in the repository layer.
/// Used by the UI to show appropriate error messages without exposing exceptions.
sealed class Failure {
  /// Human-readable error message for display to the user.
  final String message;

  const Failure(this.message);
}

/// Failure originating from API/network errors.
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Failure originating from local database errors.
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// Failure originating from GPS/location service errors.
class LocationFailure extends Failure {
  const LocationFailure(super.message);
}

/// Failure originating from protobuf or CSV data format errors.
class ParseFailure extends Failure {
  const ParseFailure(super.message);
}
