import 'package:mockito/mockito.dart';
import 'package:ibge_cnae/src/common/patterns/result_pattern.dart';
import 'package:ibge_cnae/src/features/settings/data/data.dart';
import 'package:ibge_cnae/src/features/settings/domain/domain.dart';

void registerSettingsDummies() {
  const error = SettingException('dummy');
  provideDummy<SettingResult>(const ErrorResult(error: error));
  provideDummy<SettingUpdateResult>(const ErrorResult(error: error));
  provideDummy<SettingDataResult>(const ErrorResult(error: error));
  provideDummy<SettingDataUpdateResult>(const ErrorResult(error: error));
}