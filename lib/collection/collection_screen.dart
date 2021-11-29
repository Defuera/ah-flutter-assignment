import 'package:ah/art_object/art_object_screen.dart';
import 'package:ah/collection/collection_bloc.dart';
import 'package:ah/common/model/data/error.dart';
import 'package:ah/common/model/data/models.dart';
import 'package:ah/common/ui/art_object_image.dart';
import 'package:ah/common/ui/error_widget.dart';
import 'package:ah/common/ui/page_loader_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Rijksmuseum collectie'),
        ),
        body: BlocProvider<CollectionBloc>(
          create: (context) => CollectionBloc()..init(),
          child: BlocBuilder<CollectionBloc, CollectionState>(
            builder: (context, state) => state.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              data: (artObjects, error, page) => (artObjects?.isEmpty ?? true)
                  ? AhErrorWidget(
                      error ?? RemoteError.unexpected(),
                      onRetry: context.read<CollectionBloc>().retry,
                    )
                  : _CollectionDetails(artObjects!, error), //todo well this should really be solved in bloc
            ),
          ),
        ),
      );
}

class _CollectionDetails extends StatefulWidget {
  const _CollectionDetails(this.artObjects, this.error, {Key? key}) : super(key: key);
  final List<ArtObject> artObjects;
  final RemoteError? error;

  @override
  _CollectionDetailsState createState() => _CollectionDetailsState();
}

class _CollectionDetailsState extends State<_CollectionDetails> with PageLoaderMixin {
  bool get _showErrorWidget => widget.error != null;

  int get _itemsCount => widget.artObjects.length + (_showErrorWidget ? 1 : 0);

  @override
  void loadNextPage() {
    context.read<CollectionBloc>().loadNextPage();
  }

  @override
  Widget build(BuildContext context) => ListView.builder(
        controller: pageLoaderScrollController,
        itemCount: _itemsCount,
        itemBuilder: (context, index) {
          if (_showErrorWidget && index == _itemsCount - 1) {
            return _FooterErrorWidget(widget.error ?? RemoteError.unexpected());
          } else {
            return _ArtObjectListItem(widget.artObjects[index]);
          }
        },
      );
}

class _ArtObjectListItem extends StatelessWidget {
  const _ArtObjectListItem(this.artObject, {Key? key}) : super(key: key);
  final ArtObject artObject;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push<void>(MaterialPageRoute(
              builder: (ctx) => ArtObjectScreen(objectId: artObject.objectNumber),
            ));
          },
          child: Card(
            clipBehavior: Clip.hardEdge,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ArtObjectImage(
                  imageUrl: artObject.headerImage?.url ?? artObject.webImage.url,
                  placeholderAsset: 'assets/images/rijksmuseum_placeholder.png',
                  aspectRatio: 3,
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    artObject.title,
                    style: Theme.of(context).textTheme.headline5?.copyWith(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    artObject.principalOrFirstMaker,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class _FooterErrorWidget extends StatelessWidget {
  const _FooterErrorWidget(this.error, {Key? key}) : super(key: key);
  final RemoteError error;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          clipBehavior: Clip.hardEdge,
          child: AhErrorWidget(
            error,
            onRetry: context.read<CollectionBloc>().loadNextPage,
          ),
        ),
      );
}
