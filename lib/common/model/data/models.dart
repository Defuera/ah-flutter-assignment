import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class ArtObject {
  final Links links;
  final String id;
  final String objectNumber;
  final String title;
  final bool hasImage;
  final String principalOrFirstMaker;
  final String longTitle;
  final bool showImage;
  final bool permitDownload;
  final ObjectImage webImage;
  final ObjectImage headerImage;
  final List<String> productionPlaces;

  ArtObject({
    required this.links,
    required this.id,
    required this.objectNumber,
    required this.title,
    required this.hasImage,
    required this.principalOrFirstMaker,
    required this.longTitle,
    required this.showImage,
    required this.permitDownload,
    required this.webImage,
    required this.headerImage,
    required this.productionPlaces,
  });

  factory ArtObject.fromJson(Map<String, dynamic> json) => _$ArtObjectFromJson(json);

  Map<String, dynamic> toJson() => _$ArtObjectToJson(this);
}

@JsonSerializable()
class Links {
  final String self;
  final String web;

  Links(this.self, this.web);

  factory Links.fromJson(Map<String, dynamic> json) => _$LinksFromJson(json);

  Map<String, dynamic> toJson() => _$LinksToJson(this);
}

@JsonSerializable()
class ObjectImage {
  final String guid;
  final int offsetPercentageX;
  final int offsetPercentageY;
  final int width;
  final int height;
  final String url;

  ObjectImage(
    this.guid,
    this.offsetPercentageX,
    this.offsetPercentageY,
    this.width,
    this.height,
    this.url,
  );

  factory ObjectImage.fromJson(Map<String, dynamic> json) => _$ObjectImageFromJson(json);

  Map<String, dynamic> toJson() => _$ObjectImageToJson(this);
}
