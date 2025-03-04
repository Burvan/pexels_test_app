import 'package:domain/models/search/search_request.dart';

abstract interface class SearchHistoryRepository {
  Future<List<SearchRequest>> getSearchHistory();
  Future<void> clearSearchHistory();
  Future<void> addQueryToHistory(String query);
}