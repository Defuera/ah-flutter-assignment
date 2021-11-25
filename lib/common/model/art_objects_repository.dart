import 'package:ah/common/ah_api.dart';
import 'package:ah/common/model/error.dart';
import 'package:ah/common/model/models.dart';
import 'package:either_option/either_option.dart';

class ArtObjectRepository {
  ArtObjectRepository(this.remote);

  AhApi remote;

  Future<Either<RemoteError, List<ArtObject>>> getCollection() => remote.getCollection();

  Future<Either<RemoteError, ArtObject>> getArtObject(String propertyId) async => Left(RemoteError.network());
}
