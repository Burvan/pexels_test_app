import 'package:core/core.dart';
import 'package:data/data.dart';
import 'package:data/entities/photo/photo_entity.dart';

class HiveProvider {
  ///SearchHistory
  static const int maxHistoryLength = 8;

  Future<List<SearchRequestEntity>> getSearchHistory() async {
    final Box<SearchRequestEntity> searchHistoryBox =
        await Hive.openBox(AppConstants.searchHistoryBox);

    final List<SearchRequestEntity> searchRequests =
        searchHistoryBox.values.toList();

    await searchHistoryBox.close();
    return searchRequests;
  }

  Future<void> clearSearchHistory() async {
    final Box<SearchRequestEntity> searchHistoryBox =
        await Hive.openBox(AppConstants.searchHistoryBox);

    await searchHistoryBox.clear();
    await searchHistoryBox.close();
  }

  Future<void> addQueryToHistory(String query) async {
    final Box<SearchRequestEntity> searchHistoryBox =
        await Hive.openBox(AppConstants.searchHistoryBox);

    final existingEntries =
        searchHistoryBox.values.where((entry) => entry.query == query).toList();

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
      final oldestKey = searchHistoryBox.keyAt(0)!;
      await searchHistoryBox.delete(oldestKey);
    }

    await searchHistoryBox.close();
  }

  ///Photos
  Future<void> savePhotosToCache(List<PhotoEntity> photos) async {
    final Box<PhotoEntity> photoBox =
        await Hive.openBox<PhotoEntity>(AppConstants.photoBox);

    await photoBox.addAll(photos);
    await photoBox.close();
  }

  Future<List<PhotoEntity>> getPhotosFromCache() async {
    final Box<PhotoEntity> photoBox =
        await Hive.openBox<PhotoEntity>(AppConstants.photoBox);

    final List<PhotoEntity> photos = photoBox.values.toList();

    await photoBox.close();
    return photos;
  }

  Future<void> clearCache() async {
    final Box<PhotoEntity> photoBox =
        await Hive.openBox<PhotoEntity>(AppConstants.photoBox);

    await photoBox.clear();
    await photoBox.close();
  }

  Future<bool> isPhotoBoxEmpty() async {
    final Box<PhotoEntity> photoBox =
        await Hive.openBox<PhotoEntity>(AppConstants.photoBox);

    final bool isBoxEmpty = photoBox.isEmpty;

    await photoBox.close();
    return isBoxEmpty;
  }

  ///Settings
  Future<bool> getTheme() async {
    final Box<String> themeBox =
        await Hive.openBox<String>(AppConstants.themeBox);

    final bool isDark =
        themeBox.get('isDark').toString() == 'true' ? true : false;

    await themeBox.close();
    return isDark;
  }

  Future<void> setTheme(bool isDark) async {
    final Box<String> themeBox =
        await Hive.openBox<String>(AppConstants.themeBox);

    await themeBox.put('isDark', isDark.toString());
    await themeBox.close();
  }
}
