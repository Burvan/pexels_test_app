part of '../mappers.dart';

class SrcMapper extends Mapper<SrcEntity, domain.Src> {
  @override
  domain.Src fromEntity(SrcEntity entity) {
    return domain.Src(
      original: entity.original,
      large2x: entity.large2x,
      large: entity.large,
      medium: entity.medium,
      small: entity.small,
      portrait: entity.portrait,
      landscape: entity.landscape,
      tiny: entity.tiny,
    );
  }

  @override
  SrcEntity toEntity(domain.Src item) {
    return SrcEntity(
      original: item.original,
      large2x: item.large2x,
      large: item.large,
      medium: item.medium,
      small: item.small,
      portrait: item.portrait,
      landscape: item.landscape,
      tiny: item.tiny,
    );
  }
}
