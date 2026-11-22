import 'package:ibge_cnae/src/common/patterns/state_pattern.dart';
import 'package:ibge_cnae/src/common/state_management/state_management.dart';
import 'package:ibge_cnae/src/features/cnae/domain/domain.dart';

typedef CnaeDetailUiState =
    StatePattern<CnaeClasseEntity, CnaeException>;

abstract class CnaeDetailViewModel extends StateManagement<CnaeDetailUiState> {
  Future<void> loadDetail(String classeId);
}

class CnaeDetailViewModelImpl extends CnaeDetailViewModel {
  final GetClasseDetailUseCase getClasseDetailUseCase;

  CnaeDetailViewModelImpl({required this.getClasseDetailUseCase});

  @override
  CnaeDetailUiState build() => const InitialState();

  @override
  Future<void> loadDetail(String classeId) async {
    emitState(const LoadingState());
    final result = await getClasseDetailUseCase(classeId);
    result.fold(
      onSuccess: (classe) => emitState(SuccessState(data: classe)),
      onError: (error) => emitState(ErrorState(error: error)),
    );
  }
}