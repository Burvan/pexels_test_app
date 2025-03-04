import 'package:domain/domain.dart';

class GetSearchHistoryUseCase
    implements FutureUseCase<List<SearchRequest>, NoParams> {
  final SearchHistoryRepository _searchHistoryRepository;

  GetSearchHistoryUseCase({
    required SearchHistoryRepository searchHistoryRepository,
  }) : _searchHistoryRepository = searchHistoryRepository;

  @override
  Future<List<SearchRequest>> execute(NoParams input) async {
    return _searchHistoryRepository.getSearchHistory();
  }
}
