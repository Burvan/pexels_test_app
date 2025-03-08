import 'dart:async';

import 'package:core/core.dart';

class InternetConnectionService {
  final Dio dio;
  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _internetConnectionController =
      StreamController<bool>.broadcast();

  Stream<bool> get onInternetStatusChanged =>
      _internetConnectionController.stream;

  InternetConnectionService({
    required this.dio,
  }) {
    _connectivity.onConnectivityChanged.listen(
      (connectivityResult) async {
        final bool isConnected = await isInternetConnection();

        _internetConnectionController.add(isConnected);
      },
    );
  }

  Future<bool> isInternetConnection() async {
    final List<ConnectivityResult> connectivityResult =
        await _connectivity.checkConnectivity();

    if (connectivityResult.isEmpty ||
        connectivityResult.contains(ConnectivityResult.none)) {
      return false;
    }

    try {
      final Response response = await dio.get(
        AppConstants.googleUrl,
        options: Options(
          validateStatus: (int? status) => status! >= 200 && status < 300,
        ),
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Internet connection check failed: $e');
      return false;
    }
  }

  void dispose() {
    _internetConnectionController.close();
  }
}
