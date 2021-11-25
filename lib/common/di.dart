import 'package:ah/common/ah_api.dart';
import 'package:ah/common/http_client.dart';
import 'package:ah/common/model/art_objects_repository.dart';
import 'package:get_it/get_it.dart';

//API key is hardcoded, should be injected, preferably on CI, and then be whitebox encrypted)
const _apiKey = '0fiuZFh4';
const _baseUrl = 'https://www.rijksmuseum.nl/api/en';

class DiModule {
  static Future<void> setup() async {
    final getIt = GetIt.instance;

    getIt
      ..registerSingleton(HttpClient(baseUrl: _baseUrl, apiKey: _apiKey))
      ..registerSingleton(AhApi(getIt.get()))
      ..registerSingleton(ArtObjectRepository(getIt.get()));
    // ..registerSingleton(PropertyRepository(getIt.get(), getIt.get()));

    await getIt.allReady();
  }
}
