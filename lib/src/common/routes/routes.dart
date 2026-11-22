import 'package:go_router/go_router.dart';
import 'package:ibge_cnae/src/features/cnae/presentation/routes/cnae_routes.dart';
import 'package:ibge_cnae/src/features/settings/presentation/routes/setting_routes.dart';

class Routes {
  static String get home => CnaeRoutes.home;

  GoRouter get routes => _routes;

  final GoRouter _routes = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: home,
    routes: [
      ...CnaeRoutes().routes,
      ...SettingRoutes().routes,
    ],
  );
}