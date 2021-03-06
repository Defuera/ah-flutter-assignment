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

  int get page => when(loading: () => 0, data: (_, __, page) => page);

  factory CollectionState.loading() = _CollectionStateLoading;

  factory CollectionState.data({
    List<ArtObject>? data,
    RemoteError? error,
    @Default(1) int page,
  }) = _CollectionStateData;
}

class CollectionBloc extends Cubit<CollectionState> {
  CollectionBloc() : super(CollectionState.loading());

  final _repository = GetIt.instance.get<CollectionRepository>(instanceName: 'api');

  List<ArtObject> get _data => state.when(loading: () => [], data: (data, _, __) => data ?? []);

  Future<void> init() => _loadPage(state.page);

  Future<void> retry() => init();

  Future<void> loadNextPage() async => _loadPage(state.page + 1);

  Future<void> _loadPage(int page) async {
    final result = await _repository.getCollection(page);
    result.fold(
      (error) {
        final stateWithError = state.when(
          loading: () => CollectionState.data(error: error, page: page - 1),
          data: (data, _, page) => CollectionState.data(data: data, error: error, page: page - 1),
        );
        emit(stateWithError);
      },
      (artObjects) => emit(CollectionState.data(data: _data + artObjects, page: page)),
    );
  }
}
