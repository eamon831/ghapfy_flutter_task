import 'package:nb_utils/nb_utils.dart';

import '/app/core/exporter.dart';

class LoginPageController extends BaseController {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController(
    text: kDebugMode ? 'johnd' : '',
  );
  final passwordController = TextEditingController(
    text: kDebugMode ? r'm38rmF$' : '',
  );
  final showPassword = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<void> login() async {
    final username = usernameController.text;
    final password = passwordController.text;
    if (kDebugMode) {
      print('Username: $username');
      print('Password: $password');
    }
    if (username.isEmptyOrNull) {
      Get.snackbar(
        'Username is required',
        'Please enter your username',
      );
      return;
    }
    if (password.isEmptyOrNull) {
      Get.snackbar(
        'Password is required',
        'Please enter your password',
      );
      return;
    }

    if(!formKey.currentState!.validate()) return;

    bool? isLogin;
    await dataFetcher(
      future: () async {
        isLogin = await services.login(
          username: usernameController.text,
          password: passwordController.text,
        );
      },
    );
    if (isLogin ?? false) {
      await prefs.setBool(key: prefIsLogin, value: true);
      Get.offAllNamed(Routes.splashPage);
    }
  }
}
