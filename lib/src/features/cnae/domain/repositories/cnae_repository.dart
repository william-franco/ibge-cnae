import 'package:ibge_cnae/src/common/patterns/result_pattern.dart';
import 'package:ibge_cnae/src/features/cnae/domain/domain.dart';

typedef CnaeListResult = ResultPattern<List<CnaeItemEntity>, CnaeException>;
typedef CnaeClasseResult = ResultPattern<CnaeClasseEntity, CnaeException>;

abstract interface class CnaeRepository {
  Future<CnaeListResult> listSecoes();

  Future<CnaeListResult> listDivisoes({required String secaoId});

  Future<CnaeListResult> listGrupos({required String divisaoId});

  Future<CnaeListResult> listClasses({required String grupoId});

  Future<CnaeClasseResult> getClasse({required String classeId});
}