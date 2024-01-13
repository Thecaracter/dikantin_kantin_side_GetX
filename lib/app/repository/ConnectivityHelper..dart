import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectivityHelper extends GetxController {
  RxBool hasConnection = true.obs;

  @override
  void onInit() {
    super.onInit();
    checkConnection();
    Connectivity().onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {
        hasConnection.value = false;
      } else {
        hasConnection.value = true;
      }
    });
  }

  void checkConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      hasConnection.value = false;
    } else {
      hasConnection.value = true;
    }
  }
}
