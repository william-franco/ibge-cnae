import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibge_cnae/src/common/state_management/state_management.dart';
import 'package:ibge_cnae/src/features/settings/presentation/models/setting_ui_model.dart';
import 'package:ibge_cnae/src/features/settings/presentation/view_models/setting_view_model.dart';

class SettingView extends StatelessWidget {
  final SettingViewModel settingViewModel;

  const SettingView({super.key, required this.settingViewModel});

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationIcon: const FlutterLogo(),
      applicationName: 'IBGE CNAE',
      applicationVersion: 'Versão 1.0.0',
      applicationLegalese: '\u{a9} 2026 William Franco',
      children: <Widget>[
        const SizedBox(height: 16),
        TextButton.icon(
          icon: const Icon(Icons.code),
          label: const Text('GitHub'),
          onPressed: () {
            settingViewModel.openUrl(
              url: Uri.parse('https://github.com/william-franco'),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Configurações'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          onPressed: () => context.pop(),
        ),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.brightness_6_outlined),
              title: const Text('Tema escuro'),
              trailing: StateBuilderWidget<SettingViewModel, SettingUiModel>(
                viewModel: settingViewModel,
                builder: (context, settingModel) {
                  return Switch(
                    value: settingModel.isDarkTheme,
                    onChanged: (bool isDarkTheme) {
                      settingViewModel.changeTheme(isDarkTheme: isDarkTheme);
                    },
                  );
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Sobre'),
              onTap: () => _showAboutDialog(context),
            ),
          ],
        ),
      ),
    );
  }
}