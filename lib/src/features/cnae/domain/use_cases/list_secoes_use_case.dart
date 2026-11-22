import 'package:ibge_cnae/src/features/cnae/domain/domain.dart';

abstract interface class ListSecoesUseCase {
  Future<CnaeListResult> call();
}

class ListSecoesUseCaseImpl implements ListSecoesUseCase {
  final CnaeRepository cnaeRepository;

  ListSecoesUseCaseImpl({required this.cnaeRepository});

  @override
  Future<CnaeListResult> call() => cnaeRepository.listSecoes();
}