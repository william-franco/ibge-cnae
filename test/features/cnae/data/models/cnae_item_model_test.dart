import 'package:flutter_test/flutter_test.dart';
import 'package:ibge_cnae/src/features/cnae/data/models/cnae_item_model.dart';

import '../../cnae_fixtures.dart';

void main() {
  test('fromJson maps id and descricao', () {
    final model = CnaeItemModel.fromJson(cnaeItemJson());

    expect(model.id, 'A');
    expect(model.descricao, 'AGRICULTURA');
  });
}