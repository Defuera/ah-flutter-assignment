import 'package:funda/common/funda_api.dart';
import 'package:funda/common/model/property.dart';

class PropertyRepository {
  PropertyRepository(this.api); //, this.local //todo local data source?
  FundaApi api;

  // LocalDataSource local;

  Future<Property> getProperty(String propertyId) {
    return api.getProperty(propertyId);
  }
}
