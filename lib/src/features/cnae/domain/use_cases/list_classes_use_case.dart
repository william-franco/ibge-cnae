import 'package:ibge_cnae/src/common/patterns/result_pattern.dart';
import 'package:ibge_cnae/src/features/cnae/domain/domain.dart';

abstract interface class ListClassesUseCase {
  Future<CnaeListResult> call(String grupoId);
}

class ListClassesUseCaseImpl implements ListClassesUseCase {
  final CnaeRepository cnaeRepository;

  ListClassesUseCaseImpl({required this.cnaeRepository});

  @override
  Future<CnaeListResult> call(String grupoId) {
    if (grupoId.trim().isEmpty) {
      return Future.value(
        const ErrorResult(error: CnaeException('Grupo inválido.')),
      );
    }
    return cnaeRepository.listClasses(grupoId: grupoId.trim());
  }
}