import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class PhotoGrid extends StatefulWidget {
  final List<Photo> photos;
  final bool isLoading;
  final bool isEndOfList;
  final VoidCallback onLoadMore;
  final Function(Photo) onPhotoTap;

  const PhotoGrid({
    super.key,
    required this.photos,
    required this.isLoading,
    required this.isEndOfList,
    required this.onLoadMore,
    required this.onPhotoTap,
  });

  @override
  State<PhotoGrid> createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        !widget.isLoading &&
        !widget.isEndOfList) {
      widget.onLoadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: _scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppSize.size8,
        childAspectRatio: AppScale.scale1,
      ),
      itemCount: widget.photos.isEmpty
          ? 0
          : widget.isEndOfList
              ? widget.photos.length
              : widget.photos.length + 1,
      itemBuilder: (_, int index) {
        if (index >= widget.photos.length) {
          return const SizedBox();
        } else {
          final photo = widget.photos[index];
          return PhotoTile(
            photo: photo,
            onTap: () => widget.onPhotoTap(photo),
          );
        }
      },
    );
  }
}
