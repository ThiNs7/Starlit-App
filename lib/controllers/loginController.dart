import 'package:get/get.dart';

class LoginController extends GetxController {
  var isLoading = false.obs; // Observável para controle de carregamento

  void toggleLoading() {
    isLoading.value = !isLoading.value; // Alterna o estado de carregamento
  }
}
