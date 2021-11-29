import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable()
class ArtObjectDetailed extends ArtObject {
  final String description;
  final String plaqueDescriptionDutch;
  final String plaqueDescriptionEnglish;
  final Map<String, dynamic> acquisition;
  final List<String> materials;
  final Map<String, dynamic> dating;

  final List<String> documentation;
  final String? physicalMedium;
  final Map<String, dynamic> label;
  final String? location;

  ArtObjectDetailed({
    //thumb repeated fields
    required Map<String, String> links,
    required String id,
    required String objectNumber,
    required String title,
    required bool hasImage,
    required String principalOrFirstMaker,
    required String longTitle,
    required bool showImage,
    required bool? permitDownload,
    required ObjectImage webImage,
    required ObjectImage? headerImage,
    required List<String> productionPlaces,

    //detailed fields
    required this.description,
    required this.plaqueDescriptionDutch,
    required this.plaqueDescriptionEnglish,
    required this.acquisition,
    required this.materials,
    required this.dating,
    required this.documentation,
    required this.physicalMedium,
    required this.label,
    required this.location,
  }) : super(
          links: links,
          id: id,
          objectNumber: objectNumber,
          title: title,
          hasImage: hasImage,
          principalOrFirstMaker: principalOrFirstMaker,
          longTitle: longTitle,
          showImage: showImage,
          permitDownload: permitDownload,
          webImage: webImage,
          headerImage: headerImage,
          productionPlaces: productionPlaces,
        );

  factory ArtObjectDetailed.fromJson(Map<String, dynamic> json) => _$ArtObjectDetailedFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ArtObjectDetailedToJson(this);
}

@JsonSerializable()
class ArtObject {
  final Map<String, String> links;
  final String id;
  final String objectNumber;
  final String title;
  final bool hasImage;
  final String principalOrFirstMaker;
  final String longTitle;
  final bool showImage;
  final bool? permitDownload;
  final ObjectImage webImage;
  final ObjectImage? headerImage;
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

extension ArtObjectDisplay on ArtObject {
  String get productionPlacesDisplay =>
      productionPlaces.isEmpty ? '' : productionPlaces.reduce((value, element) => '$value, $element').trim();
}
