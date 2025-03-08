import 'package:domain/domain.dart';

class CheckInternetConnectionUseCase implements FutureUseCase<bool, NoParams> {
  final PhotoRepository _photoRepository;

  CheckInternetConnectionUseCase({
    required PhotoRepository photoRepository,
  }) : _photoRepository = photoRepository;

  @override
  Future<bool> execute(NoParams input) async {
    return _photoRepository.checkInternetConnection();
  }


}
