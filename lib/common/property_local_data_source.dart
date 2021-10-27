//
//
// import 'package:funda/common/model/property.dart';
//
// abstract class PropertyDataSource {
//   Future<Property> getProperty();
//
//   Future<void> setProperty(Property property);
// }
//
// class PropertyLocalDataSource extends PropertyDataSource {
//
//   final cacheMap = <String, Property>{};
//
//   @override
//   Future<Property> getProperty() {
//     // TODO: implement getProperty
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<void> setProperty(Property property) {
//     cacheMap[property.id]
//   }
//
// }