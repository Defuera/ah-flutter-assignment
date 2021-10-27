import 'package:either_option/either_option.dart';
import 'package:funda/common/funda_api.dart';
import 'package:funda/common/model/error.dart';
import 'package:funda/common/model/property.dart';

class PropertyRepository {
  PropertyRepository(this.api); //, this.local //todo local data source?
  FundaApi api;

  // LocalDataSource local;

  Future<Either<RemoteError, Property>> getProperty(String propertyId) => api.getProperty(propertyId);
}
