import 'package:material_ui/material_ui.dart';
import 'package:ibge_cnae/src/features/cnae/domain/entities/cnae_item_entity.dart';
import 'package:ibge_cnae/src/features/cnae/presentation/models/cnae_level.dart';

class CnaeListTileWidget extends StatelessWidget {
  final CnaeItemEntity item;
  final CnaeLevel level;
  final VoidCallback? onTap;

  const CnaeListTileWidget({
    super.key,
    required this.item,
    required this.level,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          child: Icon(level.icon, size: 22),
        ),
        title: Text(
          item.descricao,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              'Código ${item.id}',
              style: theme.textTheme.labelLarge,
            ),
            Text(
              level.childTapHint,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
        isThreeLine: true,
        trailing: level.childLevel != null
            ? const Icon(Icons.chevron_right)
            : null,
      ),
    );
  }
}