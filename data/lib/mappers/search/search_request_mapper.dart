part of '../mappers.dart';

class SearchRequestMapper
    extends Mapper<SearchRequestEntity, domain.SearchRequest> {
  @override
  domain.SearchRequest fromEntity(SearchRequestEntity entity) {
    return domain.SearchRequest(
      id: entity.id,
      query: entity.query,
      queryTime: entity.queryTime,
    );
  }

  @override
  SearchRequestEntity toEntity(domain.SearchRequest item) {
    return SearchRequestEntity(
      id: item.id,
      query: item.query,
      queryTime: item.queryTime,
    );
  }
}
