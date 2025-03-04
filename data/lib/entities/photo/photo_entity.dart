import 'package:core/core.dart';
import 'package:data/entities/photo/src_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'photo_entity.g.dart';

@HiveType(typeId: 2)
@JsonSerializable(createToJson: false)
class PhotoEntity {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int? width;

  @HiveField(2)
  final int? height;

  @HiveField(3)
  final String? url;

  @HiveField(4)
  final String? photographer;

  @HiveField(5)
  final String? photographerUrl;

  @HiveField(6)
  final int? photographerId;

  @HiveField(7)
  final String? avgColor;

  @HiveField(8)
  final String? alt;

  @HiveField(9)
  final bool liked;

  @HiveField(10)
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
