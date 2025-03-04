import 'package:core/core.dart';
import 'package:data/data.dart';


class HiveProvider {
  static const int maxHistoryLength = 3;

  Future<List<SearchRequestEntity>> getSearchHistory() async {
    final Box<SearchRequestEntity> searchHistoryBox =
        await Hive.openBox('history');

    final List<SearchRequestEntity> searchRequests =
        searchHistoryBox.values.toList();

    await searchHistoryBox.close();
    return searchRequests;
  }

  Future<void> clearSearchHistory() async {
    final Box<SearchRequestEntity> searchHistoryBox =
        await Hive.openBox('history');

    await searchHistoryBox.clear();
    await searchHistoryBox.close();
  }

  Future<void> addQueryToHistory(String query) async {
    final Box<SearchRequestEntity> searchHistoryBox =
        await Hive.openBox('history');

    final SearchRequestEntity searchRequest = SearchRequestEntity(
      query: query,
      queryTime: DateTime.now(),
    );

    await searchHistoryBox.add(searchRequest);

    if (searchHistoryBox.length > maxHistoryLength) {
      final SearchRequestEntity oldestRequest = searchHistoryBox.keyAt(0);
      await searchHistoryBox.delete(oldestRequest);
    }

    await searchHistoryBox.close();
  }
}
