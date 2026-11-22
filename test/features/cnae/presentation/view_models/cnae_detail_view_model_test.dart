import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ibge_cnae/src/common/patterns/result_pattern.dart';
import 'package:ibge_cnae/src/common/patterns/state_pattern.dart';
import 'package:ibge_cnae/src/features/cnae/domain/domain.dart';
import 'package:ibge_cnae/src/features/cnae/presentation/view_models/cnae_detail_view_model.dart';

import '../../cnae_fixtures.dart';
import '../../cnae_mocks.mocks.dart';

void main() {
  setUpAll(registerDummies);

  late MockGetClasseDetailUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockGetClasseDetailUseCase();
  });

  test('loadDetail emits success', () async {
    when(mockUseCase(any)).thenAnswer(
      (_) async => SuccessResult(value: cnaeClasseEntity()),
    );
    final viewModel = CnaeDetailViewModelImpl(
      getClasseDetailUseCase: mockUseCase,
    );

    await viewModel.loadDetail('01113');

    expect(
      viewModel.state,
      isA<SuccessState<CnaeClasseEntity, CnaeException>>(),
    );
  });
}