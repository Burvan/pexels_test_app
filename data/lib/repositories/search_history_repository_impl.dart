import 'package:data/data.dart';
import 'package:data/entities/search/search_request_entity.dart';
import 'package:domain/domain.dart';

class SearchHistoryRepositoryImpl implements SearchHistoryRepository {
  final HiveProvider _hiveProvider;
  final MapperFactory mapper;

  SearchHistoryRepositoryImpl({
    required this.mapper,
    required HiveProvider hiveProvider,
  }) : _hiveProvider = hiveProvider;

  @override
  Future<void> addQueryToHistory(String query) async {
    await _hiveProvider.addQueryToHistory(query);
  }

  @override
  Future<void> clearSearchHistory() async {
    await _hiveProvider.clearSearchHistory();
  }

  @override
  Future<List<SearchRequest>> getSearchHistory() async {
    final List<SearchRequestEntity> entities =
        await _hiveProvider.getSearchHistory();

    return entities
        .map((SearchRequestEntity entity) =>
            mapper.searchRequestMapper.fromEntity(entity))
        .toList();
  }
}
