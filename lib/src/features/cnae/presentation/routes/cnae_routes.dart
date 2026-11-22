import 'package:go_router/go_router.dart';
import 'package:ibge_cnae/src/common/dependency_injectors/dependency_injector.dart';
import 'package:ibge_cnae/src/features/cnae/domain/domain.dart';
import 'package:ibge_cnae/src/features/cnae/presentation/cnae_presentation_registry.dart';
import 'package:ibge_cnae/src/features/cnae/presentation/models/cnae_breadcrumb_item.dart';
import 'package:ibge_cnae/src/features/cnae/presentation/models/cnae_level.dart';
import 'package:ibge_cnae/src/features/cnae/presentation/views/views.dart';

class CnaeRoutes {
  static const String home = '/';
  static String divisoesPath(String secaoId) => '/secoes/$secaoId/divisoes';
  static String gruposPath(String divisaoId) => '/divisoes/$divisaoId/grupos';
  static String classesPath(String grupoId) => '/grupos/$grupoId/classes';
  static String classeDetailPath(String classeId) => '/classes/$classeId';

  List<GoRoute> get routes => _routes;

  final List<GoRoute> _routes = [
    GoRoute(
      path: home,
      builder: (context, state) {
        final viewModel = locator<CnaePresentationRegistry>().listViewModel(
          key: 'secoes',
          load: () => locator<ListSecoesUseCase>()(),
        );
        return CnaeLevelListView(
          title: 'Seções CNAE',
          level: CnaeLevel.secao,
          viewModel: viewModel,
          showSettingsAction: true,
          showHierarchyGuide: true,
          onItemTap: (context, item) {
            context.push(
              divisoesPath(item.id),
              extra: item.descricao,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/secoes/:secaoId/divisoes',
      builder: (context, state) {
        final secaoId = state.pathParameters['secaoId']!;
        final secaoDescricao = state.extra as String?;
        final secaoLabel = secaoDescricao != null
            ? 'Seção $secaoId — $secaoDescricao'
            : 'Seção $secaoId';
        final viewModel = locator<CnaePresentationRegistry>().listViewModel(
          key: 'divisoes:$secaoId',
          load: () => locator<ListDivisoesUseCase>().call(secaoId),
        );
        return CnaeLevelListView(
          title: 'Divisões — $secaoLabel',
          level: CnaeLevel.divisao,
          viewModel: viewModel,
          breadcrumbs: [
            const CnaeBreadcrumbItem(label: 'Seções', location: home),
            CnaeBreadcrumbItem(label: secaoLabel),
          ],
          onItemTap: (context, item) {
            context.push(
              gruposPath(item.id),
              extra: item.descricao,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/divisoes/:divisaoId/grupos',
      builder: (context, state) {
        final divisaoId = state.pathParameters['divisaoId']!;
        final divisaoDescricao = state.extra as String?;
        final divisaoLabel = divisaoDescricao != null
            ? 'Divisão $divisaoId — $divisaoDescricao'
            : 'Divisão $divisaoId';
        final viewModel = locator<CnaePresentationRegistry>().listViewModel(
          key: 'grupos:$divisaoId',
          load: () => locator<ListGruposUseCase>().call(divisaoId),
        );
        return CnaeLevelListView(
          title: 'Grupos — $divisaoLabel',
          level: CnaeLevel.grupo,
          viewModel: viewModel,
          breadcrumbs: [
            const CnaeBreadcrumbItem(label: 'Seções', location: home),
            CnaeBreadcrumbItem(label: divisaoLabel),
          ],
          onItemTap: (context, item) {
            context.push(
              classesPath(item.id),
              extra: item.descricao,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/grupos/:grupoId/classes',
      builder: (context, state) {
        final grupoId = state.pathParameters['grupoId']!;
        final grupoDescricao = state.extra as String?;
        final grupoLabel = grupoDescricao != null
            ? 'Grupo $grupoId — $grupoDescricao'
            : 'Grupo $grupoId';
        final viewModel = locator<CnaePresentationRegistry>().listViewModel(
          key: 'classes:$grupoId',
          load: () => locator<ListClassesUseCase>().call(grupoId),
        );
        return CnaeLevelListView(
          title: 'Classes — $grupoLabel',
          level: CnaeLevel.classe,
          viewModel: viewModel,
          breadcrumbs: [
            const CnaeBreadcrumbItem(label: 'Seções', location: home),
            CnaeBreadcrumbItem(label: grupoLabel),
          ],
          onItemTap: (context, item) {
            context.push(classeDetailPath(item.id));
          },
        );
      },
    ),
    GoRoute(
      path: '/classes/:classeId',
      builder: (context, state) {
        final classeId = state.pathParameters['classeId']!;
        final viewModel = locator<CnaePresentationRegistry>().detailViewModel(
          classeId: classeId,
          getClasseDetailUseCase: locator<GetClasseDetailUseCase>(),
        );
        return CnaeDetailView(
          classeId: classeId,
          viewModel: viewModel,
        );
      },
    ),
  ];
}