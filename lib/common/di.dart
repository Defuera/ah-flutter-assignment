import 'package:funda/common/funda_api.dart';
import 'package:funda/common/http_client.dart';
import 'package:funda/common/property_local_data_source.dart';
import 'package:funda/common/property_repository.dart';
import 'package:get_it/get_it.dart';

//let's assume I'm inserting it via build parameters and actually store key itself on CI
const _apiKey = 'ac1b0b1572524640a0ecc54de453ea9f';

class DiModule {
  static Future<void> setup() async {
    final getIt = GetIt.instance;

    getIt
      ..registerSingleton(HttpClient(apiKey: _apiKey))
      ..registerSingleton(FundaApi(GetIt.instance.get()))
      ..registerSingleton(PropertyLocalDataSource())
      ..registerSingleton(PropertyRepository(GetIt.instance.get(), GetIt.instance.get()));

    await getIt.allReady();
  }
}
