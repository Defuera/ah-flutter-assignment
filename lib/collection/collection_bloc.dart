import 'package:ah/common/model/collection_repository.dart';
import 'package:ah/common/model/data/error.dart';
import 'package:ah/common/model/data/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';

part 'collection_bloc.freezed.dart';

@freezed
class CollectionState with _$CollectionState {

  CollectionState._();

  int get page => when(loading: () => 0, error: (_) => 0, data: (_, page) => page);
  List<ArtObject> get data => when(loading: () => [], error: (_) => [], data: (data, _) => data);

  factory CollectionState.loading() = _CollectionStateLoading;

  factory CollectionState.error(RemoteError error) = _CollectionStateError;

  factory CollectionState.data(List<ArtObject> data, int page) = _CollectionStateData;
}

class CollectionBloc extends Cubit<CollectionState> {
  CollectionBloc() : super(CollectionState.loading());

  final _repository = GetIt.instance.get<CollectionRepository>(instanceName: 'api');

  Future<void> init() async {
    final loadingPage = state.page;
    final result = await _repository.getCollection(loadingPage);
    result.fold(
      (error) => emit(CollectionState.error(error)),
      (artObjects) => emit(CollectionState.data(artObjects, loadingPage)),
    );
  }

  Future<void> retry() => init();

  Future<void>  loadNextPage() async {
    final loadingPage = state.page + 1;
    final result = await _repository.getCollection(loadingPage);
    result.fold(
          (error) => emit(CollectionState.error(error)),
          (artObjects) => emit(CollectionState.data(state.data + artObjects, loadingPage)),
    );
  }
}
