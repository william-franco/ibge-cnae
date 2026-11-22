import 'package:get_it/get_it.dart';
import 'package:ibge_cnae/src/common/services/connection_service.dart';
import 'package:ibge_cnae/src/common/services/http_service.dart';
import 'package:ibge_cnae/src/common/services/storage_service.dart';
import 'package:ibge_cnae/src/common/services/url_launcher_service.dart';
import 'package:ibge_cnae/src/features/cnae/cnae.dart';
import 'package:ibge_cnae/src/features/cnae/presentation/cnae_presentation_registry.dart';
import 'package:ibge_cnae/src/features/settings/settings.dart';

final locator = GetIt.instance;

void dependencyInjector() {
  _startConnectionService();
  _startHttpService();
  _startStorageAndLauncher();
  _startFeatureCnae();
  _startCnaePresentationRegistry();
  _startFeatureSettings();
}

void _startCnaePresentationRegistry() {
  locator.registerLazySingleton<CnaePresentationRegistry>(
    () => CnaePresentationRegistry(),
  );
}

Future<void> initDependencies() async {
  await locator<StorageService>().initStorage();
  await locator<SettingViewModel>().getTheme();
}

void _startConnectionService() {
  locator.registerLazySingleton<ConnectionService>(
    () => ConnectionServiceImpl(),
  );
}

void _startHttpService() {
  locator.registerLazySingleton<HttpService>(() => HttpServiceImpl());
}

void _startStorageAndLauncher() {
  locator.registerLazySingleton<StorageService>(() => StorageServiceImpl());
  locator.registerLazySingleton<UrlLauncherService>(
    () => UrlLauncherServiceImpl(),
  );
}

void _startFeatureCnae() {
  locator.registerCachedFactory<CnaeDataSource>(
    () => CnaeRemoteDataSourceImpl(
      connectionService: locator<ConnectionService>(),
      httpService: locator<HttpService>(),
    ),
  );
  locator.registerCachedFactory<CnaeRepository>(
    () => CnaeRepositoryImpl(dataSource: locator<CnaeDataSource>()),
  );
  locator.registerCachedFactory<ListSecoesUseCase>(
    () => ListSecoesUseCaseImpl(cnaeRepository: locator<CnaeRepository>()),
  );
  locator.registerCachedFactory<ListDivisoesUseCase>(
    () => ListDivisoesUseCaseImpl(cnaeRepository: locator<CnaeRepository>()),
  );
  locator.registerCachedFactory<ListGruposUseCase>(
    () => ListGruposUseCaseImpl(cnaeRepository: locator<CnaeRepository>()),
  );
  locator.registerCachedFactory<ListClassesUseCase>(
    () => ListClassesUseCaseImpl(cnaeRepository: locator<CnaeRepository>()),
  );
  locator.registerCachedFactory<GetClasseDetailUseCase>(
    () => GetClasseDetailUseCaseImpl(cnaeRepository: locator<CnaeRepository>()),
  );
}

void _startFeatureSettings() {
  locator.registerCachedFactory<SettingDataSource>(
    () => SettingDataSourceImpl(storageService: locator<StorageService>()),
  );
  locator.registerCachedFactory<SettingRepository>(
    () => SettingRepositoryImpl(
      settingDataSource: locator<SettingDataSource>(),
      urlLauncherService: locator<UrlLauncherService>(),
    ),
  );
  locator.registerCachedFactory<ReadThemeUseCase>(
    () => ReadThemeUseCaseImpl(settingRepository: locator<SettingRepository>()),
  );
  locator.registerCachedFactory<UpdateThemeUseCase>(
    () =>
        UpdateThemeUseCaseImpl(settingRepository: locator<SettingRepository>()),
  );
  locator.registerCachedFactory<OpenUrlUseCase>(
    () => OpenUrlUseCaseImpl(settingRepository: locator<SettingRepository>()),
  );
  locator.registerLazySingleton<SettingViewModel>(
    () => SettingViewModelImpl(
      readThemeUseCase: locator<ReadThemeUseCase>(),
      updateThemeUseCase: locator<UpdateThemeUseCase>(),
      openUrlUseCase: locator<OpenUrlUseCase>(),
    ),
  );
}

void resetDependencies() {
  locator.reset();
}