import 'package:domain/domain.dart';

class AddRequestToHistoryUseCase implements FutureUseCase<void, String> {
  final SearchHistoryRepository _searchHistoryRepository;

  AddRequestToHistoryUseCase({
    required SearchHistoryRepository searchHistoryRepository,
  }) : _searchHistoryRepository = searchHistoryRepository;

  @override
  Future<void> execute(String input) async {
    await _searchHistoryRepository.addQueryToHistory(input);
  }
}
