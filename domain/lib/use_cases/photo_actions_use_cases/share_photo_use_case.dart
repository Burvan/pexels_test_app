import 'package:domain/domain.dart';

class SharePhotoUseCase implements FutureUseCase<void, String> {
  final PhotoRepository _photoRepository;

  SharePhotoUseCase({
    required PhotoRepository photoRepository,
  }) : _photoRepository = photoRepository;

  @override
  Future<void> execute(String input) async{
    await _photoRepository.sharePhoto(input);
  }
}
