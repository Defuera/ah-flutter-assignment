import 'package:either_option/either_option.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:funda/common/model/error.dart';
import 'package:funda/common/utils/either_option_extensions.dart';
import 'package:funda/property_details/model/property_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks_registration.dart';

Future<void> main() async {
  setUp(() {
    registerFallbackValue(MockProperty());
    registerAllDependencies();
  });

  test(
    'Given no cached local instance, when getting property, then get from remote, store in cache and return',
    () async {
      final remote = mockFundaApi;
      final local = mockPropertyLocalDataSource;
      final testInstance = PropertyRepository(remote, local);
      final mockProperty = MockProperty();

      // Given

      when(() => local.getProperty(any())).thenAnswer((_) => Future.value(null));
      when(() => local.setProperty(any(), any())).thenAnswer((_) => Future.value());
      when(() => remote.getProperty(any())).thenAnswer((_) => Future.value(Right(mockProperty)));

      // When
      final result = await testInstance.getProperty('some_id');

      // Then
      expect(result.valueOrNull, mockProperty);
      verify(() => local.setProperty('some_id', mockProperty)).called(1);
    },
  );

  test(
    "Given there's cached local instance, when getting property, then return from cache and do not load from remote",
    () async {
      final remote = mockFundaApi;
      final local = mockPropertyLocalDataSource;
      final testInstance = PropertyRepository(remote, local);
      final mockProperty = MockProperty();

      // Given

      when(() => local.getProperty(any())).thenAnswer((_) => Future.value(mockProperty));
      when(() => local.setProperty(any(), any())).thenAnswer((_) => Future.value());
      when(() => remote.getProperty(any())).thenAnswer((_) => Future.value(Right(mockProperty)));

      // When
      final result = await testInstance.getProperty('some_id');

      // Then
      expect(result.valueOrNull, mockProperty);
      verifyNever(() => remote.getProperty('some_id'));
      verifyNever(() => local.setProperty('some_id', mockProperty));
    },
  );

  test(
    'Given remote returns error, when getting property, then propagate error, do not store cache',
    () async {
      final remote = mockFundaApi;
      final local = mockPropertyLocalDataSource;
      final testInstance = PropertyRepository(remote, local);
      final theError = RemoteError.network();

      // Given

      when(() => local.getProperty(any())).thenAnswer((_) => Future.value(null));
      when(() => local.setProperty(any(), any())).thenAnswer((_) => Future.value());
      when(() => remote.getProperty(any())).thenAnswer((_) => Future.value(Left(theError)));

      // When
      final result = await testInstance.getProperty('some_id');

      // Then
      expect(result.errorOrNull, theError);
      verifyNever(() => local.setProperty(any(), any()));
    },
  );
}
