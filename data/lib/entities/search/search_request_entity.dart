import 'package:core/core.dart';

part 'search_request_entity.g.dart';

@HiveType(typeId: 1)
class SearchRequestEntity {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String query;

  @HiveField(2)
  final DateTime queryTime;

  SearchRequestEntity({
    this.id,
    required this.query,
    required this.queryTime,
  });
}