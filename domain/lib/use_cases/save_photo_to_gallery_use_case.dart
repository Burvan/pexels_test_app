import 'package:domain/domain.dart';

class SavePhotoToGalleryUseCase implements FutureUseCase<void, String> {
  final PhotoRepository _photoRepository;

  SavePhotoToGalleryUseCase({
    required PhotoRepository photoRepository,
  }) : _photoRepository = photoRepository;

  @override
  Future<void> execute(String input) async {
    await _photoRepository.saveToGallery(input);
  }
  
  
}
