import 'package:flutter_test/flutter_test.dart';
import 'package:ibge_cnae/src/common/patterns/result_pattern.dart';
import 'package:ibge_cnae/src/common/patterns/state_pattern.dart';
import 'package:ibge_cnae/src/features/cnae/data/models/cnae_item_model.dart';
import 'package:ibge_cnae/src/features/cnae/domain/domain.dart';
import 'package:ibge_cnae/src/features/cnae/presentation/cnae_presentation_registry.dart';

void main() {
  test('listViewModel returns same instance for the same key', () async {
    final registry = CnaePresentationRegistry();

    final first = registry.listViewModel(
      key: 'secoes',
      load: () async => SuccessResult(
        value: [CnaeItemModel(id: 'A', descricao: 'Secao A')],
      ),
    );

    await first.loadItems();

    final second = registry.listViewModel(
      key: 'secoes',
      load: () async => const ErrorResult(
        error: CnaeException('unused'),
      ),
    );

    expect(identical(first, second), isTrue);
    expect(
      second.state,
      isA<SuccessState<List<CnaeItemEntity>, CnaeException>>(),
    );
  });
}