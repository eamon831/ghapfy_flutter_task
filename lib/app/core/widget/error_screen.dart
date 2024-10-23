import 'package:nb_utils/nb_utils.dart';

import '/app/core/exporter.dart';

class ErrorScreen extends StatefulWidget {
  final String errorMessage;
  final String errorCode;
  const ErrorScreen({
    required this.errorMessage,
    required this.errorCode,
    super.key,
  });

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(
        0.85,
      ),
      body: Center(
        child: Container(
          height: 300,
          width: double.infinity,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.colorPrimary,
            borderRadius: const BorderRadius.all(
              Radius.circular(
                10,
              ),
            ),
            border: Border.all(
              color: AppColors.appBarIconColor,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.errorMessage,
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              20.height,
              SelectiveButton(
                onPressed: Get.back,
                text: 'Close',
                textColor: Colors.white,
                icon: TablerIcons.x,
                iconColor: Colors.white,
                color: Colors.transparent,
                padding: 10,
                isSelected: true,
                width: 100,
                margin: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
