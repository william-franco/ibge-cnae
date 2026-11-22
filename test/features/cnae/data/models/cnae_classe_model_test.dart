import 'package:flutter_test/flutter_test.dart';
import 'package:ibge_cnae/src/features/cnae/data/models/cnae_classe_model.dart';

import '../../cnae_fixtures.dart';

void main() {
  test('fromJson maps hierarchy and observacoes', () {
    final model = CnaeClasseModel.fromJson(cnaeClasseJson());

    expect(model.id, '01113');
    expect(model.secaoId, 'A');
    expect(model.grupoId, '011');
    expect(model.observacoes, hasLength(2));
  });
}