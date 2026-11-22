import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ibge_cnae/src/common/patterns/result_pattern.dart';
import 'package:ibge_cnae/src/features/cnae/data/models/cnae_item_model.dart';
import 'package:ibge_cnae/src/features/cnae/domain/domain.dart';

import '../../cnae_fixtures.dart';
import '../../cnae_mocks.mocks.dart';

void main() {
  setUpAll(registerDummies);

  late MockCnaeRepository mockRepository;

  setUp(() {
    mockRepository = MockCnaeRepository();
  });

  group('ListDivisoesUseCase', () {
    late ListDivisoesUseCaseImpl useCase;

    setUp(() {
      useCase = ListDivisoesUseCaseImpl(cnaeRepository: mockRepository);
    });

    test('rejects empty secao id', () async {
      final result = await useCase('  ');

      expect(result, isA<ErrorResult>());
      verifyNever(mockRepository.listDivisoes(secaoId: anyNamed('secaoId')));
    });

    test('delegates to repository', () async {
      when(
        mockRepository.listDivisoes(secaoId: anyNamed('secaoId')),
      ).thenAnswer(
        (_) async => SuccessResult(
          value: [CnaeItemModel.fromJson(cnaeItemJson())],
        ),
      );

      final result = await useCase('A');

      expect(result, isA<SuccessResult>());
      verify(mockRepository.listDivisoes(secaoId: 'A')).called(1);
    });
  });

  group('GetClasseDetailUseCase', () {
    late GetClasseDetailUseCaseImpl useCase;

    setUp(() {
      useCase = GetClasseDetailUseCaseImpl(cnaeRepository: mockRepository);
    });

    test('rejects empty classe id', () async {
      final result = await useCase('');

      expect(result, isA<ErrorResult>());
    });
  });
}