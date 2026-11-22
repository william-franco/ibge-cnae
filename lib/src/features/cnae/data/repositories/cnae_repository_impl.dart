import 'package:ibge_cnae/src/common/patterns/result_pattern.dart';
import 'package:ibge_cnae/src/features/cnae/data/data_sources/data_sources.dart';
import 'package:ibge_cnae/src/features/cnae/domain/domain.dart';

class CnaeRepositoryImpl implements CnaeRepository {
  final CnaeDataSource dataSource;

  CnaeRepositoryImpl({required this.dataSource});

  @override
  Future<CnaeListResult> listSecoes() async {
    final result = await dataSource.listSecoes();
    return _mapList(result);
  }

  @override
  Future<CnaeListResult> listDivisoes({required String secaoId}) async {
    final result = await dataSource.listDivisoes(secaoId: secaoId);
    return _mapList(result);
  }

  @override
  Future<CnaeListResult> listGrupos({required String divisaoId}) async {
    final result = await dataSource.listGrupos(divisaoId: divisaoId);
    return _mapList(result);
  }

  @override
  Future<CnaeListResult> listClasses({required String grupoId}) async {
    final result = await dataSource.listClasses(grupoId: grupoId);
    return _mapList(result);
  }

  @override
  Future<CnaeClasseResult> getClasse({required String classeId}) async {
    final result = await dataSource.getClasse(classeId: classeId);
    return result.fold<CnaeClasseResult>(
      onSuccess: (classe) => SuccessResult(value: classe),
      onError: (error) => ErrorResult(error: error),
    );
  }

  CnaeListResult _mapList(CnaeListResult result) {
    return result.fold<CnaeListResult>(
      onSuccess: (items) => SuccessResult(value: items),
      onError: (error) => ErrorResult(error: error),
    );
  }
}