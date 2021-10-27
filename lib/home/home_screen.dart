import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funda/common/model/property.dart';
import 'package:funda/common/utils/price_formatter.dart';
import 'package:funda/common/utils/text_style_extentions.dart';
import 'package:funda/home/home_bloc.dart';

//todo unknown error
//todo network error with retry button
//todo improve ui according to funda website
//todo add image placeholder
//todo add button linking to google maps
//todo localization
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) => state.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (errorText) => _ErrorWidget(errorText),
              data: (property) => _DetailedPropertyWidget(property),
            ),
          ),
        ),
      );
}

//photo
//address
// postcode and place

// price

//Omschrijving

// WoonOppervlakte  PerceelOppervlakte
class _DetailedPropertyWidget extends StatelessWidget {
  const _DetailedPropertyWidget(this.property);

  final Property property;

  @override
  Widget build(BuildContext context) => ListView(
        children: [
          Image.network(property.mainPhotoUrl ?? ''), //todo placeholder

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (property.address != null)
                  Text(
                    property.address!,
                    style: Theme.of(context).textTheme.headline5.boldAndBlack,
                  ),
                const SizedBox(height: 8),
                Text(
                  '${property.postcode ?? ''} ${property.place ?? ''}',
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _IconedText(icon: Icons.crop_square, title: '${property.livingArea} m²'),
                    _IconedText(icon: Icons.zoom_out_map, title: '${property.groundArea} m²'),
                    _IconedText(icon: Icons.bed, title: '${property.totalBedrooms}'),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  formatPrice(property.price),
                  style: Theme.of(context).textTheme.headline5.boldAndBlack,
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                Text(
                  'Description',
                  style: Theme.of(context).textTheme.headline5.boldAndBlack,
                ),
                const SizedBox(height: 16),
                if (property.completeDescription != null)
                  Text(
                    property.completeDescription!,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
              ],
            ),
          ),
        ],
      );
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget(this.errorText, {Key? key}) : super(key: key);

  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _IconedText extends StatelessWidget {
  const _IconedText({required this.icon, required this.title, Key? key}) : super(key: key);

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Icon(icon, color: Colors.grey),
          Padding(
            padding: const EdgeInsets.only(left: 4, right: 12),
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ],
      );
}
