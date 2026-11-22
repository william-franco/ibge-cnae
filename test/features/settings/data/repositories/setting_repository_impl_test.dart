import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ibge_cnae/src/common/patterns/result_pattern.dart';
import 'package:ibge_cnae/src/features/settings/data/data.dart';

import '../../settings_fixtures.dart';
import '../../settings_mocks.mocks.dart';

void main() {
  setUpAll(registerSettingsDummies);

  group('SettingRepositoryImpl', () {
    late MockSettingDataSource mockSettingDataSource;
    late MockUrlLauncherService mockUrlLauncherService;
    late SettingRepositoryImpl repository;

    setUp(() {
      mockSettingDataSource = MockSettingDataSource();
      mockUrlLauncherService = MockUrlLauncherService();
      repository = SettingRepositoryImpl(
        settingDataSource: mockSettingDataSource,
        urlLauncherService: mockUrlLauncherService,
      );
    });

    test('readTheme delegates to data source', () async {
      when(mockSettingDataSource.readTheme()).thenAnswer(
        (_) async => SuccessResult(value: SettingModel(isDarkTheme: true)),
      );

      final result = await repository.readTheme();

      expect(result, isA<SuccessResult>());
      verify(mockSettingDataSource.readTheme()).called(1);
    });

    test('openUrl delegates to url launcher', () async {
      final url = Uri.parse('https://github.com/william-franco');
      when(mockUrlLauncherService.openUrl(url: url)).thenAnswer((_) async {});

      await repository.openUrl(url: url);

      verify(mockUrlLauncherService.openUrl(url: url)).called(1);
    });
  });
}