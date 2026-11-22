import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:ibge_cnae/src/common/patterns/result_pattern.dart';
import 'package:ibge_cnae/src/features/cnae/data/data_sources/cnae_remote_data_source_impl.dart';
import 'package:ibge_cnae/src/features/cnae/domain/exceptions/cnae_exception.dart';

import '../../cnae_fixtures.dart';
import '../../cnae_mocks.mocks.dart';

void main() {
  setUpAll(registerDummies);

  late CnaeRemoteDataSourceImpl dataSource;
  late MockConnectionService mockConnectionService;
  late MockHttpService mockHttpService;

  setUp(() {
    mockConnectionService = MockConnectionService();
    mockHttpService = MockHttpService();
    dataSource = CnaeRemoteDataSourceImpl(
      connectionService: mockConnectionService,
      httpService: mockHttpService,
    );
    when(mockConnectionService.checkConnection()).thenAnswer((_) async {});
    when(mockConnectionService.isConnected).thenReturn(true);
  });

  void stubGet(int? statusCode, dynamic data) {
    when(
      mockHttpService.getData(path: anyNamed('path')),
    ).thenAnswer(
      (_) async => (statusCode: statusCode, data: data, error: null),
    );
  }

  group('listSecoes', () {
    test('returns items on success', () async {
      stubGet(200, cnaeListJson());

      final result = await dataSource.listSecoes();

      expect(result, isA<SuccessResult>());
      expect((result as SuccessResult).value, hasLength(2));
      verify(mockHttpService.getData(path: '/secoes')).called(1);
    });

    test('returns error when offline', () async {
      when(mockConnectionService.isConnected).thenReturn(false);

      final result = await dataSource.listSecoes();

      expect(result, isA<ErrorResult>());
    });
  });

  group('getClasse', () {
    test('parses classe json', () async {
      stubGet(200, cnaeClasseJson());

      final result = await dataSource.getClasse(classeId: '01113');

      expect(result, isA<SuccessResult>());
      final classe = (result as SuccessResult).value;
      expect(classe.id, '01113');
      verify(mockHttpService.getData(path: '/classes/01113')).called(1);
    });

    test('returns 404 message', () async {
      stubGet(404, null);

      final result = await dataSource.getClasse(classeId: '00000');

      expect(result, isA<ErrorResult>());
      final message = (result as ErrorResult).error as CnaeException;
      expect(message.message, contains('não encontrado'));
    });
  });
}