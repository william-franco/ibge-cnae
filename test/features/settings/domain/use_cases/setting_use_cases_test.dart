import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ibge_cnae/src/common/patterns/result_pattern.dart';
import 'package:ibge_cnae/src/features/settings/data/data.dart';
import 'package:ibge_cnae/src/features/settings/domain/domain.dart';

import '../../settings_fixtures.dart';
import '../../settings_mocks.mocks.dart';

void main() {
  setUpAll(registerSettingsDummies);

  late MockSettingRepository mockRepository;

  setUp(() {
    mockRepository = MockSettingRepository();
  });

  group('ReadThemeUseCase', () {
    test('delegates to repository', () async {
      when(mockRepository.readTheme()).thenAnswer(
        (_) async => SuccessResult(value: SettingModel(isDarkTheme: false)),
      );
      final useCase = ReadThemeUseCaseImpl(settingRepository: mockRepository);

      await useCase();

      verify(mockRepository.readTheme()).called(1);
    });
  });

  group('UpdateThemeUseCase', () {
    test('delegates to repository', () async {
      when(
        mockRepository.updateTheme(isDarkTheme: anyNamed('isDarkTheme')),
      ).thenAnswer((_) async => const SuccessResult(value: null));
      final useCase = UpdateThemeUseCaseImpl(settingRepository: mockRepository);

      await useCase(isDarkTheme: true);

      verify(mockRepository.updateTheme(isDarkTheme: true)).called(1);
    });
  });

  group('OpenUrlUseCase', () {
    test('delegates to repository', () async {
      final url = Uri.parse('https://github.com/william-franco');
      when(mockRepository.openUrl(url: url)).thenAnswer((_) async {});
      final useCase = OpenUrlUseCaseImpl(settingRepository: mockRepository);

      await useCase(url: url);

      verify(mockRepository.openUrl(url: url)).called(1);
    });
  });
}