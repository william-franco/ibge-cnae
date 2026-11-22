import 'package:mockito/annotations.dart';
import 'package:ibge_cnae/src/common/services/storage_service.dart';
import 'package:ibge_cnae/src/common/services/url_launcher_service.dart';
import 'package:ibge_cnae/src/features/settings/data/data_sources/setting_data_source.dart';
import 'package:ibge_cnae/src/features/settings/domain/domain.dart';

@GenerateMocks([
  StorageService,
  UrlLauncherService,
  SettingDataSource,
  SettingRepository,
  ReadThemeUseCase,
  UpdateThemeUseCase,
  OpenUrlUseCase,
])
void main() {}