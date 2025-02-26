part of '../mappers.dart';

class PhotoMapper extends Mapper<PhotoEntity, domain.Photo> {
  final SrcMapper _srcMapper;

  PhotoMapper({
    required SrcMapper srcMapper,
  }) : _srcMapper = srcMapper;

  @override
  domain.Photo fromEntity(PhotoEntity entity) {
    return domain.Photo(
      id: entity.id,
      width: entity.width ?? 0,
      height: entity.height ?? 0,
      url: entity.url ?? '',
      photographer: entity.photographer ?? '',
      photographerUrl: entity.photographerUrl ?? '',
      photographerId: entity.photographerId ?? 0,
      avgColor: entity.avgColor ?? '',
      alt: entity.alt ?? '',
      liked: entity.liked,
      src: _srcMapper.fromEntity(entity.src), 
    );
  }

  @override
  PhotoEntity toEntity(domain.Photo item) {
    return PhotoEntity(
      id: item.id,
      width: item.width,
      height: item.height,
      url: item.url,
      photographer: item.photographer,
      photographerUrl: item.photographerUrl,
      photographerId: item.photographerId,
      avgColor: item.avgColor,
      alt: item.alt,
      liked: item.liked,
      src: _srcMapper.toEntity(item.src),
    );
  }
}
