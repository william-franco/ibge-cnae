import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ibge_cnae/src/common/patterns/result_pattern.dart';
import 'package:ibge_cnae/src/features/cnae/data/models/cnae_item_model.dart';
import 'package:ibge_cnae/src/features/cnae/data/repositories/cnae_repository_impl.dart';
import '../../cnae_fixtures.dart';
import '../../cnae_mocks.mocks.dart';

void main() {
  setUpAll(registerDummies);

  late MockCnaeDataSource mockDataSource;
  late CnaeRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockCnaeDataSource();
    repository = CnaeRepositoryImpl(dataSource: mockDataSource);
  });

  test('listSecoes delegates to data source', () async {
    when(mockDataSource.listSecoes()).thenAnswer(
      (_) async => SuccessResult(
        value: [
          CnaeItemModel.fromJson(cnaeItemJson()),
        ],
      ),
    );

    final result = await repository.listSecoes();

    expect(result, isA<SuccessResult>());
    verify(mockDataSource.listSecoes()).called(1);
  });
}