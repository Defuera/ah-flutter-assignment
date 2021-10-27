import 'package:funda/common/funda_api.dart';
import 'package:funda/common/http_client.dart';
import 'package:funda/property_details/model/property_local_data_source.dart';
import 'package:funda/property_details/model/property_repository.dart';
import 'package:get_it/get_it.dart';

//API key is hardcoded, should be injected, preferably on CI, and then be whitebox encrypted)
const _apiKey = 'ac1b0b1572524640a0ecc54de453ea9f';

class DiModule {
  static Future<void> setup() async {
    final getIt = GetIt.instance;

    getIt
      ..registerSingleton(HttpClient(apiKey: _apiKey))
      ..registerSingleton(FundaApi(getIt.get()))
      ..registerSingleton(PropertyLocalDataSource())
      ..registerSingleton(PropertyRepository(getIt.get(), getIt.get()));

    await getIt.allReady();
  }
}
