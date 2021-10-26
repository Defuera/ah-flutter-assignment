import 'package:funda/common/http_client.dart';
import 'package:funda/common/model/property.dart';

const _propertyEndpoint = '/feeds/Aanbod.svc/json/detail/[key]/koop/[id]/';

class FundaApi {
  FundaApi(this.client);

  final HttpClient client;

  Future<Property> getProperty(String propertyId) async {
    final propertyJson = await client.getJson(_propertyEndpoint.replaceAll('[id]', propertyId));
    if (propertyJson == null) {
      throw 'UnexpectedError'; //todo introduce model, also Network model
    }

    return Property.fromJson(propertyJson);
  }
}
