import 'package:funda/common/funda_api.dart';
import 'package:funda/common/http_client.dart';
import 'package:funda/common/model/property.dart';
import 'package:funda/property_details/model/property_local_data_source.dart';
import 'package:funda/property_details/model/property_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockProperty extends Mock implements Property {}

class MockHttpClient extends Mock implements HttpClient {}

class MockFundaApi extends Mock implements FundaApi {}

class MockPropertyLocalDataSource extends Mock implements PropertyLocalDataSource {}

class MockPropertyRepository extends Mock implements PropertyRepository {}

final mockHttpClient = MockHttpClient();
final mockFundaApi = MockFundaApi();
final mockPropertyLocalDataSource = MockPropertyLocalDataSource();
final mockPropertyRepository = MockPropertyRepository();

void registerAllDependencies() {
  final getIt = GetIt.instance;

  getIt.reset();

  reset(mockHttpClient);
  reset(mockFundaApi);
  reset(mockPropertyLocalDataSource);
  reset(mockPropertyRepository);

  getIt.registerLazySingleton<HttpClient>(() => mockHttpClient);
  getIt.registerLazySingleton<FundaApi>(() => mockFundaApi);
  getIt.registerLazySingleton<PropertyLocalDataSource>(() => mockPropertyLocalDataSource);
  getIt.registerLazySingleton<PropertyRepository>(() => mockPropertyRepository);
}
