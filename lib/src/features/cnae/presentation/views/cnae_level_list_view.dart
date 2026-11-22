import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibge_cnae/src/common/design/widgets/feedback_view_widget.dart';
import 'package:ibge_cnae/src/common/patterns/state_pattern.dart';
import 'package:ibge_cnae/src/common/state_management/state_management.dart';
import 'package:ibge_cnae/src/features/cnae/domain/domain.dart';
import 'package:ibge_cnae/src/features/cnae/presentation/models/cnae_breadcrumb_item.dart';
import 'package:ibge_cnae/src/features/cnae/presentation/models/cnae_level.dart';
import 'package:ibge_cnae/src/features/cnae/presentation/routes/cnae_routes.dart';
import 'package:ibge_cnae/src/features/cnae/presentation/view_models/view_models.dart';
import 'package:ibge_cnae/src/features/cnae/presentation/widgets/widgets.dart';
import 'package:ibge_cnae/src/features/settings/presentation/routes/setting_routes.dart';

class CnaeLevelListView extends StatefulWidget {
  final String title;
  final CnaeLevel level;
  final CnaeListViewModel viewModel;
  final void Function(BuildContext context, CnaeItemEntity item) onItemTap;
  final List<CnaeBreadcrumbItem> breadcrumbs;
  final bool showSettingsAction;
  final bool showHierarchyGuide;

  const CnaeLevelListView({
    super.key,
    required this.title,
    required this.level,
    required this.viewModel,
    required this.onItemTap,
    this.breadcrumbs = const [],
    this.showSettingsAction = false,
    this.showHierarchyGuide = false,
  });

  @override
  State<CnaeLevelListView> createState() => _CnaeLevelListViewState();
}

class _CnaeLevelListViewState extends State<CnaeLevelListView> {
  CnaeListViewModel get _viewModel => widget.viewModel;

  @override
  void initState() {
    super.initState();
    if (_viewModel.state is InitialState) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _viewModel.loadItems());
    }
  }

  void _onCodeSubmit(String code) {
    context.push(CnaeRoutes.classeDetailPath(code));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: context.canPop()
            ? IconButton(
                icon: const Icon(Icons.arrow_back_outlined),
                onPressed: () => context.pop(),
              )
            : null,
        title: Text(widget.title),
        actions: widget.showSettingsAction
            ? [
                IconButton(
                  icon: const Icon(Icons.settings_outlined),
                  tooltip: 'Configurações',
                  onPressed: () => context.push(SettingRoutes.setting),
                ),
              ]
            : null,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.showHierarchyGuide) const CnaeHierarchyGuideWidget(),
          CnaeBreadcrumbBarWidget(items: widget.breadcrumbs),
          CnaeSearchFieldWidget(
            onQueryChanged: _viewModel.applySearchQuery,
            onCodeSubmit: _onCodeSubmit,
          ),
          Expanded(
            child: StateBuilderWidget<CnaeListViewModel, CnaeListUiState>(
              viewModel: _viewModel,
              builder: (context, state) {
                return switch (state) {
                  InitialState() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  LoadingState() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  SuccessState(data: final items) => RefreshIndicator(
                      onRefresh: _viewModel.loadItems,
                      child: items.isEmpty
                          ? ListView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              children: [
                                FeedbackViewWidget(
                                  icon: Icons.search_off,
                                  title: _viewModel.isFiltering
                                      ? 'Nenhum resultado'
                                      : 'Nenhum item encontrado',
                                  message: _viewModel.isFiltering
                                      ? 'Nenhum item neste nível corresponde à sua busca.'
                                      : null,
                                ),
                              ],
                            )
                          : ListView.separated(
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                              itemCount: items.length,
                              separatorBuilder: (_, _) =>
                                  const SizedBox(height: 8),
                              itemBuilder: (context, index) {
                                final item = items[index];
                                return CnaeListTileWidget(
                                  level: widget.level,
                                  item: item,
                                  onTap: () => widget.onItemTap(context, item),
                                );
                              },
                            ),
                    ),
                  ErrorState(error: final error) => FeedbackViewWidget(
                      icon: Icons.error_outline,
                      title: 'Não foi possível carregar',
                      message: error.message,
                      actionLabel: 'Tentar novamente',
                      onAction: _viewModel.loadItems,
                    ),
                };
              },
            ),
          ),
        ],
      ),
    );
  }
}