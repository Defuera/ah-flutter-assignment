import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:funda/common/model/error.dart';
import 'package:funda/common/model/property.dart';
import 'package:funda/property_details/model/property_repository.dart';
import 'package:get_it/get_it.dart';

class PropertyDetailsState {
  factory PropertyDetailsState.loading() => PropertyDetailsState._(isLoading: true);

  factory PropertyDetailsState.error(RemoteError error) => PropertyDetailsState._(error: error);

  factory PropertyDetailsState.data(Property data) => PropertyDetailsState._(data: data);

  PropertyDetailsState._({this.isLoading = false, this.error, this.data});

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

  @override
  bool operator ==(Object other) {
    //todo do not look here 👀, this is a very bad, not reflective equals
    if (other is! PropertyDetailsState) {
      return false;
    }
    return isLoading && other.isLoading || error != null && error == other.error || data != null && data == other.data;
  }
}

class PropertyDetailsBloc extends Cubit<PropertyDetailsState> {
  PropertyDetailsBloc(this.propertyId) : super(PropertyDetailsState.loading());

  final String propertyId;

  final _propertyRepository = GetIt.instance.get<PropertyRepository>();

  Future<void> init() async {
    final result = await _propertyRepository.getProperty(propertyId);
    result.fold(
      (error) => emit(PropertyDetailsState.error(error)),
      (property) => emit(PropertyDetailsState.data(property)),
    );
  }

  Future<void> retry() => init();
}
