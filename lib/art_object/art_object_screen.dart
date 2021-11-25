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
  Widget build(BuildContext context) => Scaffold(
        body: BlocProvider<ArtObjectBloc>(
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
            builder: (context, state) => state.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              data: (artObject, error) {
                if (artObject != null) {
                  return _DetailedArtObjectWidget(artObject);
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

class _DetailedArtObjectWidget extends StatelessWidget {
  const _DetailedArtObjectWidget(this.artObject);

  final ArtObject artObject;

  @override
  Widget build(BuildContext context) => SafeArea(
        top: false,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Image.network(artObject.webImage.url),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    artObject.longTitle,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    artObject.longTitle,
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    artObject.principalOrFirstMaker,
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  Text(
                    artObject.productionPlaces.reduce((value, element) => '$value, $element').trim(),
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
