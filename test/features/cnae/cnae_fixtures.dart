import 'package:mockito/mockito.dart';
import 'package:ibge_cnae/src/common/patterns/result_pattern.dart';
import 'package:ibge_cnae/src/features/cnae/data/models/models.dart';
import 'package:ibge_cnae/src/features/cnae/domain/domain.dart';

void registerDummies() {
  const error = CnaeException('dummy');
  provideDummy<CnaeListResult>(const ErrorResult(error: error));
  provideDummy<CnaeClasseResult>(const ErrorResult(error: error));
}

Map<String, dynamic> cnaeItemJson({
  String id = 'A',
  String descricao = 'AGRICULTURA',
}) =>
    {
      'id': id,
      'descricao': descricao,
    };

List<Map<String, dynamic>> cnaeListJson({int count = 2}) =>
    List.generate(count, (i) => cnaeItemJson(id: 'id$i', descricao: 'DESC $i'));

Map<String, dynamic> cnaeClasseJson() => {
      'id': '01113',
      'descricao': 'CULTIVO DE CEREAIS',
      'grupo': {
        'id': '011',
        'descricao': 'PRODUÇÃO DE LAVOURAS TEMPORÁRIAS',
        'divisao': {
          'id': '01',
          'descricao': 'AGRICULTURA, PECUÁRIA E SERVIÇOS RELACIONADOS',
          'secao': {
            'id': 'A',
            'descricao':
                'AGRICULTURA, PECUÁRIA, PRODUÇÃO FLORESTAL, PESCA E AQÜICULTURA',
          },
        },
      },
      'observacoes': ['Observação 1', 'Observação 2'],
    };

CnaeClasseEntity cnaeClasseEntity() => CnaeClasseModel.fromJson(cnaeClasseJson());