import 'package:bloc_test/bloc_test.dart';
import 'package:either_option/either_option.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:funda/common/model/error.dart';
import 'package:funda/property_details/property_details_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks_registration.dart';

final _mockProperty = MockProperty();
final _error = RemoteError.unexpected();

void main() {
  setUp(registerAllDependencies);

  blocTest<PropertyDetailsBloc, PropertyDetailsState>(
    'Given repository returns data, when bloc is initialized, then data state is emitted',
    build: () {
      when(() => mockPropertyRepository.getProperty(any())).thenAnswer((_) => Future.value(Right(_mockProperty)));

      return PropertyDetailsBloc('the_id');
    },
    act: (bloc) => bloc.init(),
    expect: () => <PropertyDetailsState>[PropertyDetailsState.data(_mockProperty)],
  );

  blocTest<PropertyDetailsBloc, PropertyDetailsState>(
    'Given repository returns error, when bloc is initialized, then error state is emitted',
    build: () {
      when(() => mockPropertyRepository.getProperty(any())).thenAnswer((_) => Future.value(Left(_error)));

      return PropertyDetailsBloc('the_id');
    },
    act: (bloc) => bloc.init(),
    expect: () => <PropertyDetailsState>[PropertyDetailsState.error(_error)],
  );

  blocTest<PropertyDetailsBloc, PropertyDetailsState>(
    'Given state is error, when retry is invoked, then data state is emitted',
    build: () {
      when(() => mockPropertyRepository.getProperty(any())).thenAnswer((_) => Future.value(Right(_mockProperty)));

      final bloc = PropertyDetailsBloc('the_id');
      bloc.emit(PropertyDetailsState.error(RemoteError.network()));
      return bloc;
    },
    act: (bloc) => bloc.retry(),
    expect: () => <PropertyDetailsState>[PropertyDetailsState.data(_mockProperty)],
  );
}
