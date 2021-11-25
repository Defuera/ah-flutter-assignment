import 'package:ah/common/model/data/error.dart';
import 'package:ah/common/model/data/models.dart';
import 'package:ah/common/model/network/api_responses.dart';
import 'package:ah/common/model/network/http_client.dart';
import 'package:dio/dio.dart';
import 'package:either_option/either_option.dart';

const _collectionEndpoint = '/collection';
const _artObjectEndpoint = '/collection/[object-number]';

class RijksDataApi {
  RijksDataApi(this.client);

  final HttpClient client;

  Future<Either<RemoteError, List<ArtObject>>> getCollection() async {
    final jsonString = client.getJson(_collectionEndpoint);
    return executeSafely<Map<String, dynamic>, List<ArtObject>>(
      jsonString,
      (json) => CollectionResponse.fromJson(json).artObjects,
    );
  }

  Future<Either<RemoteError, ArtObject>> getArtObject(String artObjectId) async =>
      executeSafely<Map<String, dynamic>, ArtObject>(
        client.getJson(_artObjectEndpoint.replaceAll('[object-number]', artObjectId)),
        (json) => ArtObject.fromJson(json),
      );
}

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
  } catch (error, st) {
    return Left(RemoteError.unexpected(error.toString()));
  }
}
