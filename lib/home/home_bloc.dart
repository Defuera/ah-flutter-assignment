import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funda/common/model/property.dart';
import 'package:funda/common/property_repository.dart';
import 'package:get_it/get_it.dart';

class HomeState {
  factory HomeState.loading() => HomeState._(isLoading: true);

  factory HomeState.error(String error) => HomeState._(error: error);

  factory HomeState.data(Property data) => HomeState._(data: data);

  HomeState._({this.isLoading = false, this.error, this.data});

  final bool isLoading;
  final String? error;
  final Property? data;

  T when<T>({
    required T Function() loading,
    required T Function(String) error,
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
  HomeBloc() : super(HomeState.loading()) {
    init();
  }

  final _propertyRepository = GetIt.instance.get<PropertyRepository>();

  Future<void> init() async {
    try {
      final property = await _propertyRepository.getProperty('092cc8ac-5e12-4654-8fed-1bcfe802771d'); //test property id
      emit(HomeState.data(property));
    } catch (error) {
      emit(HomeState.error(error.toString()));
    }
  }
}
