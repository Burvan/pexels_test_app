part of 'mappers.dart';

class MapperFactory {
  SrcMapper get srcMapper => SrcMapper();
  PhotoMapper get photoMapper => PhotoMapper(srcMapper: srcMapper);
  SearchRequestMapper get searchRequestMapper => SearchRequestMapper();
}