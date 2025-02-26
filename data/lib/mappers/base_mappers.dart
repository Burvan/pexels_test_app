part of 'mappers.dart';

abstract class Mapper<A, B> {
  const Mapper();

  B fromEntity(A entity);

  A toEntity(B item);
}

extension ListMapper<A, B> on Mapper<A, B> {
  List<B> fromList(List<A>? entities) {
    return entities?.map(fromEntity).toList() ?? <B>[];
  }

  List<A> toList(List<B> items) {
    return items.map(toEntity).toList();
  }
}