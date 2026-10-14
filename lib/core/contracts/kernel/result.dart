sealed class Result<T, F> {
  const Result();
}

final class Success<T, F> extends Result<T, F> {
  const Success(this.value);

  final T value;

  @override
  bool operator ==(Object other) =>
      other is Success<T, F> && other.value == value;

  @override
  int get hashCode => Object.hash(Success, value);
}

final class Failure<T, F> extends Result<T, F> {
  const Failure(this.reason);

  final F reason;

  @override
  bool operator ==(Object other) =>
      other is Failure<T, F> && other.reason == reason;

  @override
  int get hashCode => Object.hash(Failure, reason);
}
