import 'package:go_router/go_router.dart';
import 'package:ibge_cnae/src/common/dependency_injectors/dependency_injector.dart';
import 'package:ibge_cnae/src/features/settings/presentation/presentation.dart';

class SettingRoutes {
  static String get setting => '/settings';

  List<GoRoute> get routes => _routes;

  final List<GoRoute> _routes = [
    GoRoute(
      path: setting,
      builder: (context, state) {
        return SettingView(
          settingViewModel: locator<SettingViewModel>(),
        );
      },
    ),
  ];
}