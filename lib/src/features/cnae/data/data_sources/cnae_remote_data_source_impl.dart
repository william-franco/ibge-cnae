import 'dart:convert';

import 'package:ibge_cnae/src/common/constants/api_constant.dart';
import 'package:ibge_cnae/src/common/patterns/result_pattern.dart';
import 'package:ibge_cnae/src/common/services/connection_service.dart';
import 'package:ibge_cnae/src/common/services/http_service.dart';
import 'package:ibge_cnae/src/features/cnae/data/data_sources/cnae_data_source.dart';
import 'package:ibge_cnae/src/features/cnae/data/models/models.dart';
import 'package:ibge_cnae/src/features/cnae/domain/domain.dart';

class CnaeRemoteDataSourceImpl implements CnaeDataSource {
  final ConnectionService connectionService;
  final HttpService httpService;

  CnaeRemoteDataSourceImpl({
    required this.connectionService,
    required this.httpService,
  });

  @override
  Future<CnaeListResult> listSecoes() =>
      _getList(path: ApiConstant.secoes);

  @override
  Future<CnaeListResult> listDivisoes({required String secaoId}) =>
      _getList(path: ApiConstant.divisoesBySecao(secaoId));

  @override
  Future<CnaeListResult> listGrupos({required String divisaoId}) =>
      _getList(path: ApiConstant.gruposByDivisao(divisaoId));

  @override
  Future<CnaeListResult> listClasses({required String grupoId}) =>
      _getList(path: ApiConstant.classesByGrupo(grupoId));

  @override
  Future<CnaeClasseResult> getClasse({required String classeId}) => _getClasse(
        path: ApiConstant.classe(classeId),
      );

  Future<CnaeListResult> _getList({required String path}) async {
    try {
      await connectionService.checkConnection();

      if (!connectionService.isConnected) {
        return const ErrorResult(
          error: CnaeException('Sem conexão com a internet.'),
        );
      }

      final result = await httpService.getData(path: path);

      if (result.statusCode == 200 && result.data != null) {
        final List<dynamic> raw = result.data is String
            ? jsonDecode(result.data as String) as List<dynamic>
            : result.data as List<dynamic>;
        final items = raw
            .map(
              (entry) => CnaeItemModel.fromJson(entry as Map<String, dynamic>),
            )
            .toList();
        return SuccessResult(value: items);
      }

      return ErrorResult(error: _mapStatusCode(result.statusCode));
    } catch (error) {
      return ErrorResult(
        error: CnaeException('Erro inesperado: $error'),
      );
    }
  }

  Future<CnaeClasseResult> _getClasse({required String path}) async {
    try {
      await connectionService.checkConnection();

      if (!connectionService.isConnected) {
        return const ErrorResult(
          error: CnaeException('Sem conexão com a internet.'),
        );
      }

      final result = await httpService.getData(path: path);

      if (result.statusCode == 200 && result.data != null) {
        final Map<String, dynamic> data = result.data is String
            ? jsonDecode(result.data as String) as Map<String, dynamic>
            : result.data as Map<String, dynamic>;
        return SuccessResult(value: CnaeClasseModel.fromJson(data));
      }

      return ErrorResult(error: _mapStatusCode(result.statusCode));
    } catch (error) {
      return ErrorResult(
        error: CnaeException('Erro inesperado: $error'),
      );
    }
  }

  CnaeException _mapStatusCode(int? statusCode) {
    return switch (statusCode) {
      404 => const CnaeException('Registro CNAE não encontrado.'),
      _ => CnaeException('Falha na requisição. Código: $statusCode'),
    };
  }
}