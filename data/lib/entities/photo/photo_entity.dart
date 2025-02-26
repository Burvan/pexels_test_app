import 'package:data/entities/photo/src_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'photo_entity.g.dart';

@JsonSerializable(createToJson: false)
class PhotoEntity {
  final int id;
  final int? width;
  final int? height;
  final String? url;
  final String? photographer;
  final String? photographerUrl;
  final int? photographerId;
  final String? avgColor;
  final String? alt;
  final bool liked;
  final SrcEntity src;

  PhotoEntity({
    required this.id,
    this.width,
    this.height,
    this.url,
    this.photographer,
    this.photographerUrl,
    this.photographerId,
    this.avgColor,
    this.alt,
    required this.liked,
    required this.src,
  });

  factory PhotoEntity.fromJson(Map<String, dynamic> json) {
    return _$PhotoEntityFromJson(json);
  }
}
