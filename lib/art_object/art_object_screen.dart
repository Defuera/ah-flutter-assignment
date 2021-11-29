import 'package:ah/art_object/art_object_bloc.dart';
import 'package:ah/common/model/data/error.dart';
import 'package:ah/common/model/data/models.dart';
import 'package:ah/common/ui/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArtObjectScreen extends StatelessWidget {
  const ArtObjectScreen({required this.objectId, Key? key}) : super(key: key);

  final String objectId;

  @override
  Widget build(BuildContext context) => BlocProvider<ArtObjectBloc>(
        create: (context) => ArtObjectBloc(objectId)..init(),
        child: BlocConsumer<ArtObjectBloc, ArtObjectState>(
          listener: (context, state) {
            final error = state.error;
            if (error != null) {
              error.when(
                network: () => _showErrorMessage(context, 'Network error'),
                unexpected: (message) => _showErrorMessage(context, message ?? 'Unexpected error'),
                server: (message, code) => _showErrorMessage(context, message),
              );
            }
          },
          builder: (context, state) => Scaffold(
            appBar: AppBar(
              title: Text(state.artObject?.title ?? ''),
            ),
            extendBodyBehindAppBar: true,
            body: state.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              data: (thumb, detailed, error) {
                if (detailed != null) {
                  return _ArtObjectDetailedWidget(detailed);
                } else if (thumb != null) {
                  return _ArtObjectBaseWidget(artObject: thumb);
                } else if (error != null) {
                  return AhErrorWidget(error);
                } else {
                  return AhErrorWidget(RemoteError.unexpected());
                }
              },
            ),
          ),
        ),
      );

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> _showErrorMessage(
    BuildContext context,
    String message,
  ) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

class _ArtObjectDetailedWidget extends StatelessWidget {
  const _ArtObjectDetailedWidget(this.artObject);

  final ArtObjectDetailed artObject;

  @override
  Widget build(BuildContext context) => _ArtObjectBaseWidget(
        artObject: artObject,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Materials: ${artObject.materials.reduce((value, element) => '$value, $element')}.',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              artObject.plaqueDescriptionDutch,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 16, height: 1.32),
            ),
          ),
        ],
      );
}

class _ArtObjectBaseWidget extends StatelessWidget {
  const _ArtObjectBaseWidget({required this.artObject, this.children});

  final ArtObject artObject;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) => SafeArea(
        top: false,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Image.network(artObject.webImage.url),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    artObject.longTitle,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    '${artObject.principalOrFirstMaker}, ${artObject.productionPlacesDisplay}',
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            ...children ?? []
          ],
        ),
      );
}
