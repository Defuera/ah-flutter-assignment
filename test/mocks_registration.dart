// import 'package:ah/common/ah_api.dart';
// import 'package:ah/common/http_client.dart';
// import 'package:ah/common/model/models.dart';
// import 'package:ah/property_details/model/property_local_data_source.dart';
// import 'package:ah/property_details/model/property_repository.dart';
// import 'package:get_it/get_it.dart';
// import 'package:mocktail/mocktail.dart';
//
// class MockProperty extends Mock implements Collection {}
//
// class MockHttpClient extends Mock implements HttpClient {}
//
// class MockAhApi extends Mock implements AhApi {}
//
// class MockPropertyLocalDataSource extends Mock implements PropertyLocalDataSource {}
//
// class MockPropertyRepository extends Mock implements PropertyRepository {}
//
// final mockHttpClient = MockHttpClient();
// final mockAhApi = MockAhApi();
// final mockPropertyLocalDataSource = MockPropertyLocalDataSource();
// final mockPropertyRepository = MockPropertyRepository();
//
// void registerAllDependencies() {
//   final getIt = GetIt.instance;
//
//   getIt.reset();
//
//   reset(mockHttpClient);
//   reset(mockAhApi);
//   reset(mockPropertyLocalDataSource);
//   reset(mockPropertyRepository);
//
//   getIt.registerLazySingleton<HttpClient>(() => mockHttpClient);
//   getIt.registerLazySingleton<AhApi>(() => mockAhApi);
//   getIt.registerLazySingleton<PropertyLocalDataSource>(() => mockPropertyLocalDataSource);
//   getIt.registerLazySingleton<PropertyRepository>(() => mockPropertyRepository);
// }
