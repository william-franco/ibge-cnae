import 'package:mockito/annotations.dart';
import 'package:ibge_cnae/src/common/services/connection_service.dart';
import 'package:ibge_cnae/src/common/services/http_service.dart';
import 'package:ibge_cnae/src/features/cnae/data/data_sources/cnae_data_source.dart';
import 'package:ibge_cnae/src/features/cnae/domain/repositories/cnae_repository.dart';
import 'package:ibge_cnae/src/features/cnae/domain/use_cases/use_cases.dart';

@GenerateMocks([
  ConnectionService,
  HttpService,
  CnaeDataSource,
  CnaeRepository,
  ListSecoesUseCase,
  ListDivisoesUseCase,
  ListGruposUseCase,
  ListClassesUseCase,
  GetClasseDetailUseCase,
])
void main() {}