import 'package:material_ui/material_ui.dart';
import 'package:ibge_cnae/src/common/dependency_injectors/dependency_injector.dart';
import 'package:ibge_cnae/src/common/design/theme_design.dart';
import 'package:ibge_cnae/src/common/routes/routes.dart';
import 'package:ibge_cnae/src/features/settings/presentation/view_models/setting_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  dependencyInjector();
  await initDependencies();
  final Routes appRoutes = Routes();
  runApp(MyApp(appRoutes: appRoutes));
}

class MyApp extends StatefulWidget {
  final Routes appRoutes;

  const MyApp({super.key, required this.appRoutes});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkTheme = false;
  late final SettingViewModel _settingViewModel;

  @override
  void initState() {
    super.initState();
    _settingViewModel = locator<SettingViewModel>();
    _applyThemeFromViewModel();
    _settingViewModel.addListener(_onSettingChanged);
  }

  void _onSettingChanged() {
    final next = _settingViewModel.state.isDarkTheme;
    if (next == _isDarkTheme) {
      return;
    }
    setState(() => _isDarkTheme = next);
  }

  void _applyThemeFromViewModel() {
    _isDarkTheme = _settingViewModel.state.isDarkTheme;
  }

  @override
  void dispose() {
    _settingViewModel.removeListener(_onSettingChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      key: const ValueKey('ibge_cnae_router'),
      title: 'IBGE CNAE',
      debugShowCheckedModeBanner: false,
      theme: ThemeDesign.light,
      darkTheme: ThemeDesign.dark,
      themeMode: _isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      routerConfig: widget.appRoutes.routes,
    );
  }
}