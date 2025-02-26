import 'package:domain/models/photo/src.dart';

class Photo {
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
  final Src src;

  Photo({
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
}
