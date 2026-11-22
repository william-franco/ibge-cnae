import 'package:ibge_cnae/src/common/patterns/state_pattern.dart';
import 'package:ibge_cnae/src/common/state_management/state_management.dart';
import 'package:ibge_cnae/src/features/cnae/domain/domain.dart';

typedef CnaeListUiState =
    StatePattern<List<CnaeItemEntity>, CnaeException>;

abstract class CnaeListViewModel extends StateManagement<CnaeListUiState> {
  Future<void> loadItems();
  void applySearchQuery(String query);
  bool get isFiltering;
  int get totalItemCount;
}

class CnaeListViewModelImpl extends CnaeListViewModel {
  final Future<CnaeListResult> Function() load;

  CnaeListViewModelImpl({required this.load});

  List<CnaeItemEntity> _allItems = [];
  String _searchQuery = '';

  @override
  bool get isFiltering => _searchQuery.trim().isNotEmpty;

  @override
  int get totalItemCount => _allItems.length;

  @override
  CnaeListUiState build() => const InitialState();

  @override
  Future<void> loadItems() async {
    emitState(const LoadingState());
    final result = await load();
    result.fold(
      onSuccess: (items) {
        _allItems = items;
        emitState(SuccessState(data: _applyFilter(_allItems)));
      },
      onError: (error) => emitState(ErrorState(error: error)),
    );
  }

  @override
  void applySearchQuery(String query) {
    _searchQuery = query;
    final current = state;
    if (current is SuccessState<List<CnaeItemEntity>, CnaeException>) {
      emitState(SuccessState(data: _applyFilter(_allItems)));
    }
  }

  List<CnaeItemEntity> _applyFilter(List<CnaeItemEntity> items) {
    final query = _searchQuery.trim().toLowerCase();
    if (query.isEmpty) {
      return List<CnaeItemEntity>.from(items);
    }
    return items
        .where(
          (item) =>
              item.id.toLowerCase().contains(query) ||
              item.descricao.toLowerCase().contains(query),
        )
        .toList();
  }
}