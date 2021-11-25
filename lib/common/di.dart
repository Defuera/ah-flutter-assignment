import 'package:ah/common/model/collection_cache.dart';
import 'package:ah/common/model/collection_repository.dart';
import 'package:ah/common/model/network/api.dart';
import 'package:ah/common/model/network/http_client.dart';
import 'package:get_it/get_it.dart';

//API key is hardcoded, should be injected, preferably on CI, and then be whitebox encrypted)
const _apiKey = '0fiuZFh4';
const _baseUrl = 'https://www.rijksmuseum.nl/api/en';

class DiModule {
  static Future<void> setup() async {
    final getIt = GetIt.instance;

    getIt
      ..registerSingleton(HttpClient(baseUrl: _baseUrl, apiKey: _apiKey))
      ..registerSingleton(RijksDataApi(getIt.get()))
      ..registerSingleton(CollectionCache())
      ..registerSingleton(CollectionRepository(getIt.get(), getIt.get()));

    await getIt.allReady();
  }
}
