import 'package:ibge_cnae/src/common/patterns/result_pattern.dart';
import 'package:ibge_cnae/src/features/cnae/domain/domain.dart';

abstract interface class ListDivisoesUseCase {
  Future<CnaeListResult> call(String secaoId);
}

class ListDivisoesUseCaseImpl implements ListDivisoesUseCase {
  final CnaeRepository cnaeRepository;

  ListDivisoesUseCaseImpl({required this.cnaeRepository});

  @override
  Future<CnaeListResult> call(String secaoId) {
    if (secaoId.trim().isEmpty) {
      return Future.value(
        const ErrorResult(error: CnaeException('Seção inválida.')),
      );
    }
    return cnaeRepository.listDivisoes(secaoId: secaoId.trim());
  }
}