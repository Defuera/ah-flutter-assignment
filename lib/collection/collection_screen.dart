import 'package:ah/art_object/art_object_screen.dart';
import 'package:ah/collection/collection_bloc.dart';
import 'package:ah/common/model/data/models.dart';
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
              error: (errorText) => AhErrorWidget(
                errorText,
                onRetry: context.read<CollectionBloc>().retry,
              ),
              data: (artObjects, page) => _CollectionDetails(artObjects),
            ),
          ),
        ),
      );
}

class _CollectionDetails extends StatefulWidget {
  const _CollectionDetails(this.artObjects, {Key? key}) : super(key: key);
  final List<ArtObject> artObjects;

  @override
  _CollectionDetailsState createState() => _CollectionDetailsState();
}

class _CollectionDetailsState extends State<_CollectionDetails> with PageLoaderMixin {
  @override
  void loadNextPage() {
    context.read<CollectionBloc>().loadNextPage();
  }

  @override
  Widget build(BuildContext context) => ListView.builder(
        controller: pageLoaderScrollController,
        itemCount: widget.artObjects.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push<void>(MaterialPageRoute(
                builder: (ctx) => ArtObjectScreen(objectId: widget.artObjects[index].objectNumber),
              ));
            },
            child: Card(
              clipBehavior: Clip.hardEdge,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 3,
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/rijksmuseum_placeholder.png',
                      image: widget.artObjects[index].headerImage?.url ?? widget.artObjects[index].webImage.url,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.artObjects[index].title,
                      style: Theme.of(context).textTheme.headline5?.copyWith(fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.artObjects[index].principalOrFirstMaker,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
