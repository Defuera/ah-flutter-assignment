import 'package:ah/common/model/collection_repository.dart';
import 'package:ah/common/model/data/error.dart';
import 'package:ah/common/model/data/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';

part 'collection_bloc.freezed.dart';

@freezed
class CollectionState with _$CollectionState {
  factory CollectionState.loading() = _CollectionStateLoading;

  factory CollectionState.error(RemoteError error) = _CollectionStateError;

  factory CollectionState.data(List<ArtObject> data) = _CollectionStateData;
}

class CollectionBloc extends Cubit<CollectionState> {
  CollectionBloc() : super(CollectionState.loading());

  final _repository = GetIt.instance.get<CollectionRepository>();

  Future<void> init() async {
    final result = await _repository.getCollection();
    result.fold(
      (error) => emit(CollectionState.error(error)),
      (property) => emit(CollectionState.data(property)),
    );
  }

  Future<void> retry() => init();
}
