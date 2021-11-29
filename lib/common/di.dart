import 'package:ah/common/model/collection_cache.dart';
import 'package:ah/common/model/collection_repository.dart';
import 'package:ah/common/model/network/http_client.dart';
import 'package:ah/common/model/network/remote_data_source.dart';
import 'package:get_it/get_it.dart';

//API key is hardcoded, should be injected, preferably on CI, and then be whitebox encrypted)
const _apiKey = '0fiuZFh4';
const _baseUrl = 'https://www.rijksmuseum.nl/api/en';

class DiModule {
  static Future<void> setup() async {
    final getIt = GetIt.instance;

    getIt
      ..registerSingleton(HttpClient(baseUrl: _baseUrl, apiKey: _apiKey))
      ..registerSingleton(CollectionCache())
      ..registerSingleton<CollectionRemoteDataSource>(RijksDataApi(getIt.get()), instanceName: 'api')
      ..registerSingleton<CollectionRemoteDataSource>(MockApi(), instanceName: 'mock_api')
      ..registerSingleton(
        CollectionRepository(getIt.get(instanceName: 'api'), getIt.get()),
        instanceName: 'api',
      )
      ..registerSingleton(
        CollectionRepository(getIt.get(instanceName: 'mock_api'), getIt.get()),
        instanceName: 'mock_api',
      );

    await getIt.allReady();
  }
}
