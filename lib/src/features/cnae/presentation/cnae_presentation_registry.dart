import 'package:ibge_cnae/src/features/cnae/domain/domain.dart';
import 'package:ibge_cnae/src/features/cnae/presentation/view_models/view_models.dart';

class CnaePresentationRegistry {
  final Map<String, CnaeListViewModel> _listViewModels = {};
  final Map<String, CnaeDetailViewModel> _detailViewModels = {};

  CnaeListViewModel listViewModel({
    required String key,
    required Future<CnaeListResult> Function() load,
  }) {
    return _listViewModels.putIfAbsent(
      key,
      () => CnaeListViewModelImpl(load: load),
    );
  }

  CnaeDetailViewModel detailViewModel({
    required String classeId,
    required GetClasseDetailUseCase getClasseDetailUseCase,
  }) {
    return _detailViewModels.putIfAbsent(
      classeId,
      () => CnaeDetailViewModelImpl(
        getClasseDetailUseCase: getClasseDetailUseCase,
      ),
    );
  }
}