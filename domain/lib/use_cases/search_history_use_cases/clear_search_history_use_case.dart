import 'package:domain/domain.dart';

class ClearSearchHistoryUseCase implements FutureUseCase<void, NoParams> {
  final SearchHistoryRepository _searchHistoryRepository;

  ClearSearchHistoryUseCase({
    required SearchHistoryRepository searchHistoryRepository,
  }) : _searchHistoryRepository = searchHistoryRepository;

  @override
  Future<void> execute(NoParams input) async {
    await _searchHistoryRepository.clearSearchHistory();
  }
}
