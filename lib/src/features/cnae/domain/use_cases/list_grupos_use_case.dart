import 'package:ibge_cnae/src/common/patterns/result_pattern.dart';
import 'package:ibge_cnae/src/features/cnae/domain/domain.dart';

abstract interface class ListGruposUseCase {
  Future<CnaeListResult> call(String divisaoId);
}

class ListGruposUseCaseImpl implements ListGruposUseCase {
  final CnaeRepository cnaeRepository;

  ListGruposUseCaseImpl({required this.cnaeRepository});

  @override
  Future<CnaeListResult> call(String divisaoId) {
    if (divisaoId.trim().isEmpty) {
      return Future.value(
        const ErrorResult(error: CnaeException('Divisão inválida.')),
      );
    }
    return cnaeRepository.listGrupos(divisaoId: divisaoId.trim());
  }
}