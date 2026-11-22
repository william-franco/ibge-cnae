import 'package:flutter/foundation.dart';
import 'package:ibge_cnae/src/common/state_management/state_management.dart';
import 'package:ibge_cnae/src/features/settings/domain/domain.dart';
import 'package:ibge_cnae/src/features/settings/presentation/models/setting_ui_model.dart';

typedef _ViewModel = StateManagement<SettingUiModel>;

abstract interface class SettingViewModel extends _ViewModel {
  Future<void> getTheme();
  Future<void> changeTheme({required bool isDarkTheme});
  Future<void> openUrl({required Uri url});
}

class SettingViewModelImpl extends _ViewModel implements SettingViewModel {
  final ReadThemeUseCase readThemeUseCase;
  final UpdateThemeUseCase updateThemeUseCase;
  final OpenUrlUseCase openUrlUseCase;

  SettingViewModelImpl({
    required this.readThemeUseCase,
    required this.updateThemeUseCase,
    required this.openUrlUseCase,
  });

  @override
  SettingUiModel build() => SettingUiModel();

  @override
  Future<void> openUrl({required Uri url}) => openUrlUseCase.call(url: url);

  @override
  Future<void> getTheme() async {
    final result = await readThemeUseCase.call();

    result.fold(
      onSuccess: (entity) => _emit(
        SettingUiModel(isDarkTheme: entity.isDarkTheme),
      ),
      onError: (_) => _emit(SettingUiModel()),
    );
  }

  @override
  Future<void> changeTheme({required bool isDarkTheme}) async {
    final previous = state;
    final optimistic = state.copyWith(isDarkTheme: isDarkTheme);
    _emit(optimistic);

    final result = await updateThemeUseCase.call(isDarkTheme: isDarkTheme);

    result.fold(
      onSuccess: (_) => _emit(optimistic),
      onError: (_) => _emit(previous),
    );
  }

  void _emit(SettingUiModel newState) {
    emitState(newState);
    debugPrint('SettingViewModel: ${state.isDarkTheme}');
  }
}