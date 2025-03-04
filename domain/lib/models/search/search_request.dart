class SearchRequest {
  final int? id;
  final String query;
  final DateTime queryTime;

  const SearchRequest({
    this.id,
    required this.query,
    required this.queryTime,
  });
}
