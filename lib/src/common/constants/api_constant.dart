class ApiConstant {
  static const String baseUrl = 'https://servicodados.ibge.gov.br/api/v2/cnae';

  static const String secoes = '/secoes';

  static String divisoesBySecao(String secaoId) => '/secoes/$secaoId/divisoes';

  static String gruposByDivisao(String divisaoId) =>
      '/divisoes/$divisaoId/grupos';

  static String classesByGrupo(String grupoId) => '/grupos/$grupoId/classes';

  static String classe(String classeId) => '/classes/$classeId';
}