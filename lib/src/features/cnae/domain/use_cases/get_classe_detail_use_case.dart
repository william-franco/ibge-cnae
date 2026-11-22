import 'package:ibge_cnae/src/common/patterns/result_pattern.dart';
import 'package:ibge_cnae/src/features/cnae/domain/domain.dart';

abstract interface class GetClasseDetailUseCase {
  Future<CnaeClasseResult> call(String classeId);
}

class GetClasseDetailUseCaseImpl implements GetClasseDetailUseCase {
  final CnaeRepository cnaeRepository;

  GetClasseDetailUseCaseImpl({required this.cnaeRepository});

  @override
  Future<CnaeClasseResult> call(String classeId) {
    if (classeId.trim().isEmpty) {
      return Future.value(
        const ErrorResult(error: CnaeException('Classe inválida.')),
      );
    }
    return cnaeRepository.getClasse(classeId: classeId.trim());
  }
}