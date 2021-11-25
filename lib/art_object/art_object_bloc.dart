import 'package:ah/common/model/art_objects_repository.dart';
import 'package:ah/common/model/error.dart';
import 'package:ah/common/model/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';

part 'art_object_bloc.freezed.dart';

@freezed
class ArtObjectState with _$ArtObjectState {
  factory ArtObjectState.loading() = _ArtObjectStateLoading;

  factory ArtObjectState.error(RemoteError error) = _ArtObjectStateError;

  factory ArtObjectState.data(ArtObject artObject) = _ArtObjectStateData;
}

class ArtObjectBloc extends Cubit<ArtObjectState> {
  ArtObjectBloc(this.propertyId) : super(ArtObjectState.loading());

  final String propertyId;

  final _repository = GetIt.instance.get<ArtObjectRepository>();

  Future<void> init() async {
    final result = await _repository.getArtObject(propertyId);
    result.fold(
      (error) => emit(ArtObjectState.error(error)),
      (property) => emit(ArtObjectState.data(property)),
    );
  }

  Future<void> retry() => init();
}
