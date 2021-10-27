import 'package:either_option/either_option.dart';
import 'package:funda/common/funda_api.dart';
import 'package:funda/common/model/error.dart';
import 'package:funda/common/model/property.dart';
import 'package:funda/common/property_local_data_source.dart';
import 'package:funda/common/utils/either_option_extensions.dart';

class PropertyRepository {
  PropertyRepository(this.remote, this.local);

  FundaApi remote;
  PropertyLocalDataSource local;

  Future<Either<RemoteError, Property>> getProperty(String propertyId) async {
    final data = await local.getProperty(propertyId);
    if (data == null) {
      final result = await remote.getProperty(propertyId);
      result.doOnRight((data) => local.setProperty(propertyId, data));
      return result;
    } else {
      return Right(data);
    }
  }
}
