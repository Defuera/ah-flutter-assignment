import 'package:flutter/material.dart';

class ArtObjectImage extends StatelessWidget {
  const ArtObjectImage({
    required this.imageUrl,
    required this.placeholderAsset,
    required this.aspectRatio,
    Key? key,
  }) : super(key: key);

  final String imageUrl;
  final String placeholderAsset;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) => AspectRatio(
        aspectRatio: aspectRatio,
        child: FadeInImage.assetNetwork(
          placeholder: placeholderAsset,
          placeholderErrorBuilder: (context, _, __) => Image.asset(placeholderAsset),
          imageErrorBuilder: (context, _, __) => Image.asset(placeholderAsset),
          image: imageUrl,
          fit: BoxFit.fitHeight,
        ),
      );
}
