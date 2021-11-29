import 'package:ah/common/model/data/error.dart';
import 'package:dio/dio.dart';
import 'package:either_option/either_option.dart';

Future<Either<RemoteError, T>> executeSafely<R, T>(
  Future<R?> networkRequest,
  T Function(R) converter,
) async {
  try {
    final result = await networkRequest;
    if (result == null) {
      return Left(RemoteError.unexpected());
    } else {
      return Right(converter(result));
    }
  } on DioError catch (error) {
    final code = error.response?.statusCode;
    final message = error.response?.statusMessage;
    if (error.type == DioErrorType.response && code != null) {
      return Left(RemoteError.server(code, message ?? ''));
    } else {
      return Left(RemoteError.network());
    }
  } catch (error) {
    return Left(RemoteError.unexpected(error.toString()));
  }
}
