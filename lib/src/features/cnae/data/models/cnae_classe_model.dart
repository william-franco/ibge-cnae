import 'package:ibge_cnae/src/features/cnae/domain/entities/cnae_classe_entity.dart';

class CnaeClasseModel extends CnaeClasseEntity {
  const CnaeClasseModel({
    required super.id,
    required super.descricao,
    required super.secaoId,
    required super.secaoDescricao,
    required super.divisaoId,
    required super.divisaoDescricao,
    required super.grupoId,
    required super.grupoDescricao,
    required super.observacoes,
  });

  factory CnaeClasseModel.fromJson(Map<String, dynamic> json) {
    final grupo = json['grupo'] as Map<String, dynamic>? ?? {};
    final divisao = grupo['divisao'] as Map<String, dynamic>? ?? {};
    final secao = divisao['secao'] as Map<String, dynamic>? ?? {};

    return CnaeClasseModel(
      id: json['id']?.toString() ?? '',
      descricao: json['descricao'] as String? ?? '',
      secaoId: secao['id']?.toString() ?? '',
      secaoDescricao: secao['descricao'] as String? ?? '',
      divisaoId: divisao['id']?.toString() ?? '',
      divisaoDescricao: divisao['descricao'] as String? ?? '',
      grupoId: grupo['id']?.toString() ?? '',
      grupoDescricao: grupo['descricao'] as String? ?? '',
      observacoes: List<String>.from(json['observacoes'] as List? ?? const []),
    );
  }
}