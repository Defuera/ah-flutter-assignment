import 'package:ah/common/http_client.dart';
import 'package:ah/common/model/api_responses.dart';
import 'package:ah/common/model/error.dart';
import 'package:ah/common/model/models.dart';
import 'package:dio/dio.dart';
import 'package:either_option/either_option.dart';

const _collectionEndpoint = '/collection'; //?key=[key]&involvedMaker=Rembrandt+van+Rijn
// const _propertyEndpoint = '/feeds/Aanbod.svc/json/detail/[key]/koop/[id]/';

class AhApi {
  AhApi(this.client);

  final HttpClient client;

  Future<Either<RemoteError, List<ArtObject>>> getCollection() async {
    final jsonString = client.getJson(_collectionEndpoint);
    return executeSafely<Map<String, dynamic>, List<ArtObject>>(
      jsonString,
      (json) => CollectionResponse.fromJson(json).artObjects,
    );
  }

// Future<Either<RemoteError, Collection>> getObjectDetails(String objectNumber) async =>
//     executeSafely(client.getJson(_collectionEndpoint.replaceAll('[id]', objectNumber)), Collection.fromJson);
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
