import 'package:material_ui/material_ui.dart';
import 'package:ibge_cnae/src/features/cnae/presentation/models/cnae_level.dart';

class CnaeHierarchyGuideWidget extends StatelessWidget {
  const CnaeHierarchyGuideWidget({super.key});

  static const _steps = [
    CnaeLevel.secao,
    CnaeLevel.divisao,
    CnaeLevel.grupo,
    CnaeLevel.classe,
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Como navegar',
              style: theme.textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Escolha uma seção e siga os níveis até a classe. '
              'Use a busca para filtrar a lista atual ou ir direto '
              'a uma classe pelo código.',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                for (var i = 0; i < _steps.length; i++) ...[
                  if (i > 0)
                    Icon(
                      Icons.arrow_forward,
                      size: 16,
                      color: theme.colorScheme.outline,
                    ),
                  Chip(
                    avatar: Icon(_steps[i].icon, size: 18),
                    label: Text(_steps[i].label),
                    visualDensity: VisualDensity.compact,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}