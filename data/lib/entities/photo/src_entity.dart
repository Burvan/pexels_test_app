import 'package:json_annotation/json_annotation.dart';

part 'src_entity.g.dart';

@JsonSerializable(createToJson: false)
class SrcEntity {
  final String original;
  final String large2x;
  final String large;
  final String medium;
  final String small;
  final String portrait;
  final String landscape;
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
