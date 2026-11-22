import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:ibge_cnae/src/common/design/widgets/feedback_view_widget.dart';
import 'package:ibge_cnae/src/common/patterns/state_pattern.dart';
import 'package:ibge_cnae/src/common/state_management/state_management.dart';
import 'package:ibge_cnae/src/features/cnae/presentation/routes/cnae_routes.dart';
import 'package:ibge_cnae/src/features/cnae/presentation/view_models/view_models.dart';
import 'package:ibge_cnae/src/features/cnae/presentation/widgets/widgets.dart';

class CnaeDetailView extends StatefulWidget {
  final String classeId;
  final CnaeDetailViewModel viewModel;

  const CnaeDetailView({
    super.key,
    required this.classeId,
    required this.viewModel,
  });

  @override
  State<CnaeDetailView> createState() => _CnaeDetailViewState();
}

class _CnaeDetailViewState extends State<CnaeDetailView> {
  CnaeDetailViewModel get _viewModel => widget.viewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadIfNeeded());
  }

  void _loadIfNeeded() {
    final shouldLoad = switch (_viewModel.state) {
      SuccessState(data: final classe) => classe.id != widget.classeId,
      _ => true,
    };
    if (shouldLoad) {
      _viewModel.loadDetail(widget.classeId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          onPressed: () => context.pop(),
        ),
        title: const Text('Detalhe da classe'),
      ),
      body: StateBuilderWidget<CnaeDetailViewModel, CnaeDetailUiState>(
        viewModel: _viewModel,
        builder: (context, state) {
          return switch (state) {
            InitialState() => const Center(child: CircularProgressIndicator()),
            LoadingState() => const Center(child: CircularProgressIndicator()),
            SuccessState(data: final classe) => ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text(
                    classe.descricao,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Código ${classe.id}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Hierarquia',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  CnaeHierarchyRowWidget(
                    label: 'Seção',
                    value: '${classe.secaoId} — ${classe.secaoDescricao}',
                    onTap: () => context.push(
                      CnaeRoutes.divisoesPath(classe.secaoId),
                      extra: classe.secaoDescricao,
                    ),
                  ),
                  CnaeHierarchyRowWidget(
                    label: 'Divisão',
                    value: '${classe.divisaoId} — ${classe.divisaoDescricao}',
                    onTap: () => context.push(
                      CnaeRoutes.gruposPath(classe.divisaoId),
                      extra: classe.divisaoDescricao,
                    ),
                  ),
                  CnaeHierarchyRowWidget(
                    label: 'Grupo',
                    value: '${classe.grupoId} — ${classe.grupoDescricao}',
                    onTap: () => context.push(
                      CnaeRoutes.classesPath(classe.grupoId),
                      extra: classe.grupoDescricao,
                    ),
                  ),
                  if (classe.observacoes.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Text(
                      'Observações',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    ...classe.observacoes.map(
                      (note) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Text(note),
                      ),
                    ),
                  ],
                ],
              ),
            ErrorState(error: final error) => FeedbackViewWidget(
                icon: Icons.error_outline,
                title: 'Não foi possível carregar',
                message: error.message,
                actionLabel: 'Tentar novamente',
                onAction: () => _viewModel.loadDetail(widget.classeId),
              ),
          };
        },
      ),
    );
  }
}