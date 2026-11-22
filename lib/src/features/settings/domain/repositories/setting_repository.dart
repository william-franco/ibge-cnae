import 'package:ibge_cnae/src/common/patterns/result_pattern.dart';
import 'package:ibge_cnae/src/features/settings/data/exceptions/setting_exception.dart';
import 'package:ibge_cnae/src/features/settings/domain/entities/setting_entity.dart';

typedef SettingResult = ResultPattern<SettingEntity, SettingException>;
typedef SettingUpdateResult = ResultPattern<void, SettingException>;

abstract interface class SettingRepository {
  Future<SettingResult> readTheme();

  Future<SettingUpdateResult> updateTheme({required bool isDarkTheme});

  Future<void> openUrl({required Uri url});
}