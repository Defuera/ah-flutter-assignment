import 'package:ah/common/model/data/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_responses.g.dart';

@JsonSerializable()
class CollectionResponse {
  final int elapsedMilliseconds;
  final int count;
  final Map<String, dynamic> countFacets;
  final List<ArtObject> artObjects;
  final List<dynamic> facets;

  CollectionResponse(
    this.elapsedMilliseconds,
    this.count,
    this.countFacets,
    this.artObjects,
    this.facets,
  );

  factory CollectionResponse.fromJson(Map<String, dynamic> json) => _$CollectionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionResponseToJson(this);
}

@JsonSerializable()
class ArtObjectResponse {
  final int elapsedMilliseconds;
  final ArtObjectDetailed artObject;

  ArtObjectResponse(
    this.elapsedMilliseconds,
    this.artObject,
  );

  factory ArtObjectResponse.fromJson(Map<String, dynamic> json) => _$ArtObjectResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ArtObjectResponseToJson(this);
}
