import 'package:core/core.dart';

class InternetConnectionService {
  final Dio dio;

  InternetConnectionService({
    required this.dio,
  });

  Future<bool> isInternetConnection() async {
    final List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    if (connectivityResult.isEmpty ||
        connectivityResult.contains(ConnectivityResult.none)) {
      return false;
    }

    try {
      final Response<Map<String, dynamic>> response = await dio.get(
        AppConstants.baseUrl,
        options: Options(
          validateStatus: (int? status) => status! >= 200 && status < 300,
        ),
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
