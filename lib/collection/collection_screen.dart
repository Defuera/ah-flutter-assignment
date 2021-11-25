import 'package:ah/art_object/art_object_screen.dart';
import 'package:ah/collection/collection_bloc.dart';
import 'package:ah/common/model/error.dart';
import 'package:ah/common/model/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Rijksmuseum colectie'),
        ),
        body: BlocProvider<CollectionBloc>(
          create: (context) => CollectionBloc()..init(),
          child: BlocBuilder<CollectionBloc, CollectionState>(
            builder: (context, state) => state.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (errorText) => _ErrorWidget(errorText),
              data: (artObjects) => _CollectionDetails(artObjects),
            ),
          ),
        ),
      );
}

class _CollectionDetails extends StatelessWidget {
  const _CollectionDetails(this.artObjects, {Key? key}) : super(key: key);

  final List<ArtObject> artObjects;

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: artObjects.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push<void>(MaterialPageRoute(
                builder: (ctx) => ArtObjectScreen(objectId: artObjects[index].id),
              ));
            },
            child: Card(
              clipBehavior: Clip.hardEdge,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInImage.assetNetwork(
                    placeholder: 'assets/images/rijksmuseum_placeholder.png',
                    image: artObjects[index].headerImage.url,
                    fit: BoxFit.fitHeight,
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      artObjects[index].title,
                      style: Theme.of(context).textTheme.headline5?.copyWith(fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      artObjects[index].principalOrFirstMaker,
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

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget(this.error, {Key? key}) : super(key: key);

  final RemoteError error;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: error.when(
            network: () => const _NetworkError(),
            unexpected: (message) => Text(message ?? 'Something went terribly wrong'),
            server: (message, code) => _ServerError(message: message, code: code),
          ),
        ),
      );
}

class _ServerError extends StatelessWidget {
  _ServerError({required this.message, required this.code, Key? key}) : super(key: key);

  final String message;
  final int code;

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) => code == 404
      ? Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Property cannot be found, try another one?',
              style: Theme.of(context).textTheme.subtitle2,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Paste property id',
                suffixIcon: IconButton(
                  color: Colors.orange,
                  icon: const Icon(Icons.send),
                  onPressed: () {}, //=> loadNewProperty(context),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange, width: 1.0),
                ),
              ),
            )
          ],
        )
      : Text('Server error $code:\n$message');

// void loadNewProperty(BuildContext context) {
//   Navigator.of(context).pop();
//   Navigator.of(context).push<void>(MaterialPageRoute<dynamic>(
//     builder: (context) => CollectionScreen(propertyId: _controller.text),
//   ));
// }
}

class _NetworkError extends StatelessWidget {
  const _NetworkError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.signal_wifi_connected_no_internet_4_rounded,
            color: Colors.orangeAccent,
            size: 84,
          ),
          ElevatedButton(
            child: Text(
              'Retry',
              style: Theme.of(context).textTheme.button?.copyWith(color: Colors.white),
            ),
            onPressed: () => context.read<CollectionBloc>().retry(),
          )
        ],
      );
}

// class _IconedText extends StatelessWidget {
//   const _IconedText({required this.icon, required this.title, Key? key}) : super(key: key);
//
//   final IconData icon;
//   final String title;
//
//   @override
//   Widget build(BuildContext context) => Row(
//         children: [
//           Icon(icon, color: Colors.grey),
//           Padding(
//             padding: const EdgeInsets.only(left: 4, right: 12),
//             child: Text(
//               title,
//               style: Theme.of(context).textTheme.bodyText2,
//             ),
//           ),
//         ],
//       );
// }
