import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funda/common/model/property.dart';
import 'package:funda/home/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    body: BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) => state.when(
              loading: () => const CircularProgressIndicator(),
              error: (errorText) => Center(child: Text(errorText)),
              data: (property) => _DetailedPropertyWidget(property),
            ),
          ),
        ),
  );
}

class _DetailedPropertyWidget extends StatelessWidget {
  const _DetailedPropertyWidget(this.property);

  final Property property;

  @override
  Widget build(BuildContext context) => Center(child: Text('Property'));
}
