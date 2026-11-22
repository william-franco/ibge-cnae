import 'package:flutter_test/flutter_test.dart';
import 'package:ibge_cnae/src/common/patterns/result_pattern.dart';
import 'package:ibge_cnae/src/common/patterns/state_pattern.dart';
import 'package:ibge_cnae/src/features/cnae/data/models/cnae_item_model.dart';
import 'package:ibge_cnae/src/features/cnae/domain/domain.dart';
import 'package:ibge_cnae/src/features/cnae/presentation/view_models/cnae_list_view_model.dart';

import '../../cnae_fixtures.dart';

void main() {
  test('loadItems emits success state', () async {
    final viewModel = CnaeListViewModelImpl(
      load: () async => SuccessResult(
        value: [CnaeItemModel.fromJson(cnaeItemJson())],
      ),
    );

  await viewModel.loadItems();

    expect(viewModel.state, isA<SuccessState<List<CnaeItemEntity>, CnaeException>>());
  });

  test('loadItems emits error state', () async {
    final viewModel = CnaeListViewModelImpl(
      load: () async => const ErrorResult(
        error: CnaeException('fail'),
      ),
    );

    await viewModel.loadItems();

    expect(viewModel.state, isA<ErrorState<List<CnaeItemEntity>, CnaeException>>());
  });

  test('applySearchQuery filters by id and descricao', () async {
    final viewModel = CnaeListViewModelImpl(
      load: () async => SuccessResult(
        value: [
          CnaeItemModel.fromJson(cnaeItemJson(id: 'A', descricao: 'Agricultura')),
          CnaeItemModel.fromJson(cnaeItemJson(id: 'B', descricao: 'Indústria')),
        ],
      ),
    );

    await viewModel.loadItems();
    viewModel.applySearchQuery('agri');

    final state = viewModel.state as SuccessState<List<CnaeItemEntity>, CnaeException>;
    expect(state.data.length, 1);
    expect(state.data.first.id, 'A');
    expect(viewModel.isFiltering, isTrue);
  });

  test('applySearchQuery empty restores full list', () async {
    final viewModel = CnaeListViewModelImpl(
      load: () async => SuccessResult(
        value: [
          CnaeItemModel.fromJson(cnaeItemJson(id: 'A')),
          CnaeItemModel.fromJson(cnaeItemJson(id: 'B')),
        ],
      ),
    );

    await viewModel.loadItems();
    viewModel.applySearchQuery('A');
    viewModel.applySearchQuery('');

    final state = viewModel.state as SuccessState<List<CnaeItemEntity>, CnaeException>;
    expect(state.data.length, 2);
    expect(viewModel.isFiltering, isFalse);
  });
}