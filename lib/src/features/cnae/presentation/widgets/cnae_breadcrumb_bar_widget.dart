import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibge_cnae/src/features/cnae/presentation/models/cnae_breadcrumb_item.dart';

class CnaeBreadcrumbBarWidget extends StatelessWidget {
  final List<CnaeBreadcrumbItem> items;

  const CnaeBreadcrumbBarWidget({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (var i = 0; i < items.length; i++) ...[
              if (i > 0)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
                    Icons.chevron_right,
                    size: 18,
                    color: theme.colorScheme.outline,
                  ),
                ),
              _BreadcrumbChip(
                item: items[i],
                isCurrent: items[i].location == null,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _BreadcrumbChip extends StatelessWidget {
  final CnaeBreadcrumbItem item;
  final bool isCurrent;

  const _BreadcrumbChip({
    required this.item,
    required this.isCurrent,
  });

  @override
  Widget build(BuildContext context) {
  final theme = Theme.of(context);

    if (isCurrent || item.location == null) {
      return Chip(
        label: Text(item.label),
        visualDensity: VisualDensity.compact,
        side: BorderSide(color: theme.colorScheme.primary),
      );
    }

    return ActionChip(
      label: Text(item.label),
      visualDensity: VisualDensity.compact,
      onPressed: () => context.go(item.location!),
    );
  }
}