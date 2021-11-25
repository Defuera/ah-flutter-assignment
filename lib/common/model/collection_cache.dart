import 'package:ah/common/model/data/models.dart';

class CollectionCache {
  final _cache = <String, ArtObject>{};

  void storeArtObject(ArtObject artObject) {}

  ArtObject? getArtObjectByNumber(String objectNumber) => _cache[objectNumber];

  Future<void> storeArtObjects(List<ArtObject> collection) async {
    collection.forEach((element) => _cache[element.objectNumber] = element);
  }
}
