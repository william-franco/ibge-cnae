import 'package:ibge_cnae/src/features/settings/domain/domain.dart';

abstract interface class ReadThemeUseCase {
  Future<SettingResult> call();
}

class ReadThemeUseCaseImpl implements ReadThemeUseCase {
  final SettingRepository settingRepository;

  ReadThemeUseCaseImpl({required this.settingRepository});

  @override
  Future<SettingResult> call() => settingRepository.readTheme();
}