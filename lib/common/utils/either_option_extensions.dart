import 'package:either_option/either_option.dart';

extension EitherExtention<L, R> on Either<L, R> {
  Future<Either<L, R>> doOnRightAsync(Future Function(R) callable) => fold(
        (error) async => Left<L, R>(error),
        (result) async {
          await callable(result);

          return Right<L, R>(result);
        },
      );

  Either<L, R> doOnRight(Function(R) callable) => fold(
        (error) => Left<L, R>(error),
        (result) {
          callable(result);

          return Right<L, R>(result);
        },
      );

  Future<Either<L, T>> mapRightAsync<T>(Future<T> Function(R) mapper) => fold(
        (error) async => Left<L, T>(error),
        (result) async {
          final mappedResult = await mapper(result);

          return Right<L, T>(mappedResult);
        },
      );
}
