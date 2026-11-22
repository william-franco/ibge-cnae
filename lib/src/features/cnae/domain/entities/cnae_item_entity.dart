class CnaeItemEntity {
  final String id;
  final String descricao;

  const CnaeItemEntity({
    required this.id,
    required this.descricao,
  });

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is CnaeItemEntity && other.id == id && other.descricao == descricao;
  }

  @override
  int get hashCode => Object.hash(id, descricao);
}