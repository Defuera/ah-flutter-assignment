import 'package:ah/common/model/collection_repository.dart';
import 'package:ah/common/model/data/error.dart';
import 'package:ah/common/model/data/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';

part 'art_object_bloc.freezed.dart';

@freezed
class ArtObjectState with _$ArtObjectState {
  ArtObjectState._();

  factory ArtObjectState.loading() = _ArtObjectStateLoading;

  factory ArtObjectState.data({ArtObject? artObject, RemoteError? error}) = _ArtObjectStateData;

  ArtObject? get artObject => when(loading: () => null, data: (artObject, error) => artObject);

  RemoteError? get error => when(loading: () => null, data: (artObject, error) => error);
}

class ArtObjectBloc extends Cubit<ArtObjectState> {
  ArtObjectBloc(this.objectId) : super(ArtObjectState.loading());

  final String objectId;

  final _repository = GetIt.instance.get<CollectionRepository>();

  Future<void> init() async {
    _repository.getArtObject(objectId).listen((result) {
      result.fold(
        (error) => emit(ArtObjectState.data(artObject: state.artObject, error: error)),
        (artObject) => emit(ArtObjectState.data(artObject: artObject)),
      );
    });
  }

  Future<void> retry() => init();
}
