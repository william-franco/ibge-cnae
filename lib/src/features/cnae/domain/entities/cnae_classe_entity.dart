class CnaeClasseEntity {
  final String id;
  final String descricao;
  final String secaoId;
  final String secaoDescricao;
  final String divisaoId;
  final String divisaoDescricao;
  final String grupoId;
  final String grupoDescricao;
  final List<String> observacoes;

  const CnaeClasseEntity({
    required this.id,
    required this.descricao,
    required this.secaoId,
    required this.secaoDescricao,
    required this.divisaoId,
    required this.divisaoDescricao,
    required this.grupoId,
    required this.grupoDescricao,
    required this.observacoes,
  });
}