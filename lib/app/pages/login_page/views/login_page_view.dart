import '/app/core/exporter.dart';
import '/app/pages/login_page/controllers/login_page_controller.dart';

// ignore: must_be_immutable
class LoginPageView extends BaseView<LoginPageController> {
  LoginPageView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackgroundColor(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 100,
              ),
              child: Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: centerMAA,
                  children: [
                    const AssetImageView(fileName: AppAssets.appLogo),
                    SizedBox(height: Get.height * 0.1),
                    TextFormField(
                      controller: controller.usernameController,
                      decoration: primaryInputDecoration.copyWith(
                        labelText: appLocalization.username,
                        hintText: appLocalization.username,
                      ),
                      validator: requiredValidator,
                      autovalidateMode: onUserInteraction,
                    ),
                    const SizedBox(height: 24),
                    Obx(
                      () => TextFormField(
                        controller: controller.passwordController,
                        decoration: primaryInputDecoration.copyWith(
                          labelText: appLocalization.password,
                          hintText: appLocalization.password,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              controller.showPassword.toggle();
                            },
                            child: Icon(
                              controller.showPassword.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                        ),
                        validator: passwordValidator,
                        autovalidateMode: onUserInteraction,
                        obscureText: !controller.showPassword.value,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: controller.login,
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                color: AppColors.colorPrimary,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.colorWhite,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
