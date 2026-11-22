import 'package:ibge_cnae/src/features/cnae/domain/entities/cnae_item_entity.dart';

class CnaeItemModel extends CnaeItemEntity {
  const CnaeItemModel({
    required super.id,
    required super.descricao,
  });

  factory CnaeItemModel.fromJson(Map<String, dynamic> json) {
    return CnaeItemModel(
      id: json['id']?.toString() ?? '',
      descricao: json['descricao'] as String? ?? '',
    );
  }
}