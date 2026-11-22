import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ibge_cnae/src/common/patterns/result_pattern.dart';
import 'package:ibge_cnae/src/features/settings/data/data.dart';
import 'package:ibge_cnae/src/features/settings/domain/domain.dart';
import 'package:ibge_cnae/src/features/settings/presentation/view_models/setting_view_model.dart';

import '../../settings_mocks.mocks.dart';

void main() {
  group('SettingViewModelImpl', () {
    late MockReadThemeUseCase mockReadThemeUseCase;
    late MockUpdateThemeUseCase mockUpdateThemeUseCase;
    late MockOpenUrlUseCase mockOpenUrlUseCase;
    late SettingViewModelImpl viewModel;

    setUpAll(() {
      provideDummy<SettingResult>(
        SuccessResult<SettingModel, SettingException>(
          value: SettingModel(isDarkTheme: false),
        ),
      );
      provideDummy<SettingResult>(
        const ErrorResult<SettingModel, SettingException>(
          error: SettingException('dummy'),
        ),
      );
      provideDummy<SettingUpdateResult>(
        const SuccessResult<void, SettingException>(value: null),
      );
      provideDummy<SettingUpdateResult>(
        const ErrorResult<void, SettingException>(
          error: SettingException('dummy'),
        ),
      );
    });

    setUp(() {
      mockReadThemeUseCase = MockReadThemeUseCase();
      mockUpdateThemeUseCase = MockUpdateThemeUseCase();
      mockOpenUrlUseCase = MockOpenUrlUseCase();
      viewModel = SettingViewModelImpl(
        readThemeUseCase: mockReadThemeUseCase,
        updateThemeUseCase: mockUpdateThemeUseCase,
        openUrlUseCase: mockOpenUrlUseCase,
      );
    });

    tearDown(() => viewModel.dispose());

    test('starts with default SettingUiModel', () {
      expect(viewModel.state.isDarkTheme, isFalse);
    });

    test('getTheme updates model on success', () async {
      when(mockReadThemeUseCase.call()).thenAnswer(
        (_) async => SuccessResult(value: SettingModel(isDarkTheme: true)),
      );

      await viewModel.getTheme();

      expect(viewModel.state.isDarkTheme, isTrue);
    });

    test('changeTheme updates model on success', () async {
      when(mockUpdateThemeUseCase.call(isDarkTheme: anyNamed('isDarkTheme')))
          .thenAnswer((_) async => const SuccessResult(value: null));

      await viewModel.changeTheme(isDarkTheme: true);

      expect(viewModel.state.isDarkTheme, isTrue);
    });

    test('openUrl delegates to use case', () async {
      final url = Uri.parse('https://github.com/william-franco');
      when(mockOpenUrlUseCase.call(url: anyNamed('url')))
          .thenAnswer((_) async {});

      await viewModel.openUrl(url: url);

      verify(mockOpenUrlUseCase.call(url: url)).called(1);
    });
  });
}