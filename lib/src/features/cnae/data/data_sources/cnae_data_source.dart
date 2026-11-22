import 'package:ibge_cnae/src/features/cnae/domain/repositories/cnae_repository.dart';

typedef CnaeListModelsResult = Future<CnaeListResult>;
typedef CnaeClasseModelResult = Future<CnaeClasseResult>;

abstract interface class CnaeDataSource {
  CnaeListModelsResult listSecoes();

  CnaeListModelsResult listDivisoes({required String secaoId});

  CnaeListModelsResult listGrupos({required String divisaoId});

  CnaeListModelsResult listClasses({required String grupoId});

  CnaeClasseModelResult getClasse({required String classeId});
}