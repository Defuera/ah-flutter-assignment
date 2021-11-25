import 'package:ah/art_object/art_object_bloc.dart';
import 'package:ah/common/model/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArtObjectScreen extends StatelessWidget {
  const ArtObjectScreen({required this.objectId, Key? key}) : super(key: key);

  final String objectId;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocProvider<ArtObjectBloc>(
          create: (context) => ArtObjectBloc(objectId)..init(),
          child: BlocBuilder<ArtObjectBloc, ArtObjectState>(
            builder: (context, state) => state.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (errorText) => _ErrorWidget(errorText),
              // data: (property) => _DetailedPropertyWidget(property),

              data: (artObject) => const Center(child: CircularProgressIndicator()),
            ),
          ),
        ),
      );
}

// class _DetailedPropertyWidget extends StatelessWidget {
//   const _DetailedPropertyWidget(this.property);
//
//   final Property property;
//
//   @override
//   Widget build(BuildContext context) => SafeArea(
//         top: false,
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             Image.network(property.mainPhotoUrl ?? ''),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   if (property.address != null)
//                     Text(
//                       property.address!,
//                       style: Theme.of(context).textTheme.headline5.boldAndBlack,
//                     ),
//                   const SizedBox(height: 8),
//                   Text(
//                     '${property.postcode ?? ''} ${property.place ?? ''}',
//                     style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.grey),
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       _IconedText(icon: Icons.crop_square, title: '${property.livingArea} m²'),
//                       _IconedText(icon: Icons.zoom_out_map, title: '${property.groundArea} m²'),
//                       _IconedText(icon: Icons.bed, title: '${property.totalBedrooms}'),
//                     ],
//                   ),
//                   const SizedBox(height: 24),
//                   Text(
//                     formatPrice(property.price),
//                     style: Theme.of(context).textTheme.headline5.boldAndBlack,
//                   ),
//                   const SizedBox(height: 16),
//                   const Divider(),
//                   const SizedBox(height: 16),
//                   Text(
//                     'Description',
//                     style: Theme.of(context).textTheme.headline5.boldAndBlack,
//                   ),
//                   const SizedBox(height: 16),
//                   if (property.completeDescription != null)
//                     Text(
//                       property.completeDescription!,
//                       style: Theme.of(context).textTheme.bodyText2,
//                     ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
// }

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
                  onPressed: () => loadNewProperty(context),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange, width: 1.0),
                ),
              ),
              onSubmitted: (_) => loadNewProperty(context),
            )
          ],
        )
      : Text('Server error $code:\n$message');

  void loadNewProperty(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).push<void>(MaterialPageRoute<dynamic>(
      builder: (context) => ArtObjectScreen(objectId: _controller.text),
    ));
  }
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
            onPressed: () => context.read<ArtObjectBloc>().retry(),
          )
        ],
      );
}
