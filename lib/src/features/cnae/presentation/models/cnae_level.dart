import 'package:material_ui/material_ui.dart';

enum CnaeLevel {
  secao,
  divisao,
  grupo,
  classe;

  String get label => switch (this) {
        CnaeLevel.secao => 'Seção',
        CnaeLevel.divisao => 'Divisão',
        CnaeLevel.grupo => 'Grupo',
        CnaeLevel.classe => 'Classe',
      };

  IconData get icon => switch (this) {
        CnaeLevel.secao => Icons.view_list_outlined,
        CnaeLevel.divisao => Icons.call_split_outlined,
        CnaeLevel.grupo => Icons.folder_outlined,
        CnaeLevel.classe => Icons.article_outlined,
      };

  String get childTapHint => switch (this) {
        CnaeLevel.secao => 'Ver divisões desta seção',
        CnaeLevel.divisao => 'Ver grupos desta divisão',
        CnaeLevel.grupo => 'Ver classes deste grupo',
        CnaeLevel.classe => 'Ver detalhe',
      };

  CnaeLevel? get childLevel => switch (this) {
        CnaeLevel.secao => CnaeLevel.divisao,
        CnaeLevel.divisao => CnaeLevel.grupo,
        CnaeLevel.grupo => CnaeLevel.classe,
        CnaeLevel.classe => null,
      };
}