import 'package:funda/common/model/property.dart';

class PropertyLocalDataSource {
  final cacheMap = <String, Property>{};

  Future<Property?> getProperty(String propertyId) async => cacheMap[propertyId];

  Future<void> setProperty(String id, Property property) async {
    cacheMap[id] = property;
  }
}
