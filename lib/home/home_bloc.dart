import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funda/common/model/error.dart';
import 'package:funda/common/model/property.dart';
import 'package:funda/common/property_repository.dart';
import 'package:get_it/get_it.dart';

class HomeState {
  factory HomeState.loading() => HomeState._(isLoading: true);

  factory HomeState.error(RemoteError error) => HomeState._(error: error);

  factory HomeState.data(Property data) => HomeState._(data: data);

  HomeState._({this.isLoading = false, this.error, this.data});

  final bool isLoading;
  final RemoteError? error;
  final Property? data;

  T when<T>({
    required T Function() loading,
    required T Function(RemoteError) error,
    required T Function(Property) data,
  }) {
    final checkedError = this.error;
    final checkedData = this.data;
    if (isLoading) {
      return loading();
    } else if (checkedError != null) {
      return error(checkedError);
    } else if (checkedData != null) {
      return data(checkedData);
    } else {
      throw Exception('Illegal state: data and error cannot be null at the same time when isLoading == false');
    }
  }
}

class HomeBloc extends Cubit<HomeState> {
  HomeBloc(this.propertyId) : super(HomeState.loading()) {
    loadData();
  }

  final String propertyId;

  final _propertyRepository = GetIt.instance.get<PropertyRepository>();

  Future<void> loadData() async {
    final result = await _propertyRepository.getProperty(propertyId);
    result.fold(
      (error) => emit(HomeState.error(error)),
      (property) => emit(HomeState.data(property)),
    );
  }

  Future<void> retry() => loadData();
}
