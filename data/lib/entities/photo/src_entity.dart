import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'src_entity.g.dart';

@HiveType(typeId: 3)
@JsonSerializable(createToJson: false)
class SrcEntity {
  @HiveField(0)
  final String original;

  @HiveField(1)
  final String large2x;

  @HiveField(2)
  final String large;

  @HiveField(3)
  final String medium;

  @HiveField(4)
  final String small;

  @HiveField(5)
  final String portrait;

  @HiveField(6)
  final String landscape;

  @HiveField(7)
  final String tiny;

  SrcEntity({
    required this.original,
    required this.large2x,
    required this.large,
    required this.medium,
    required this.small,
    required this.portrait,
    required this.landscape,
    required this.tiny,
  });

  factory SrcEntity.fromJson(Map<String, dynamic> json) {
    return _$SrcEntityFromJson(json);
  }
}
