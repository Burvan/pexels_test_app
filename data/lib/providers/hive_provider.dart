import 'package:core/core.dart';
import 'package:data/data.dart';


class HiveProvider {
  static const int maxHistoryLength = 8;

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

    final existingEntries = searchHistoryBox.values
        .where((entry) => entry.query == query)
        .toList();

    for (var entry in existingEntries) {
      final key = searchHistoryBox.keyAt(
        searchHistoryBox.values.toList().indexOf(entry),
      );
      await searchHistoryBox.delete(key);
    }

    final SearchRequestEntity searchRequest = SearchRequestEntity(
      query: query,
      queryTime: DateTime.now(),
    );

    await searchHistoryBox.add(searchRequest);

    if (searchHistoryBox.length > maxHistoryLength) {
      final  oldestKey = searchHistoryBox.keyAt(0)!;
      await searchHistoryBox.delete(oldestKey);
    }

    await searchHistoryBox.close();
  }
}
