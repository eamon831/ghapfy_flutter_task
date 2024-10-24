import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nb_utils/nb_utils.dart';

import '/app/core/exporter.dart';
import '/app/service/client/error_catcher.dart';

abstract class BaseController extends GetxController {
  final Logger logger = BuildConfig.instance.config.logger;

  AppLocalizations get appLocalization => AppLocalizations.of(Get.context!)!;
  Services get services => Services.instance;
  LoggedUser get loggedUser => LoggedUser();

  final pageLimit = 10;

  final prefs = SessionManager();

  final dbHelper = DbHelper.instance;

  final logoutController = false.obs;

  //Reload the page
  final _refreshController = false.obs;

  bool refreshPage({
    required bool refresh,
  }) {
    return _refreshController(refresh);
  }

  //Controls page state
  final _pageSateController = PageState.defaultState.obs;

  PageState get pageState => _pageSateController.value;

  PageState updatePageState(PageState state) => _pageSateController(state);

  PageState resetPageState() => _pageSateController(PageState.defaultState);

  PageState showLoading() => updatePageState(PageState.loading);

  PageState hideLoading() => resetPageState();

  final _messageController = ''.obs;

  String get message => _messageController.value;

  String showMessage(String msg) => _messageController(msg);

  final _errorMessageController = ''.obs;

  String get errorMessage => _errorMessageController.value;

  void showErrorMessage(String msg) {
    _errorMessageController(msg);
  }

  void underDevelopment() {
    // toast(appLocalization.underDevelopment);
  }

  final _successMessageController = ''.obs;

  String get successMessage => _messageController.value;

  String showSuccessMessage(String msg) => _successMessageController(msg);

  Future<bool> hasInternet() async {
    final connectivityResults = await Connectivity().checkConnectivity();

    if (connectivityResults.isEmpty) {
      return false;
    }

    final isConnected =
        connectivityResults.contains(ConnectivityResult.mobile) ||
            connectivityResults.contains(ConnectivityResult.wifi);

    if (!isConnected) {
      return false;
    }

    return InternetConnectionChecker().hasConnection;
  }

  Future<void> refreshData() async {}

  Future<void> changeLocale() async {
    Get.updateLocale(
      Get.locale == const Locale('en', 'US')
          ? const Locale('bn', 'BD')
          : const Locale('en', 'US'),
    );
    await prefs.setString(
      key: prefLanguage,
      value: Get.locale!.languageCode,
    );
  }

  Future<void> showLoader() async {
    Future.delayed(
      Duration.zero,
      () => Get.to(
        const LoaderScreen(),
        opaque: false,
        fullscreenDialog: true,
      ),
    );
  }

  void closeLoader() {
    Get.back();
  }

  Future<void> dataFetcher({
    required Future<void> Function() future,
    bool shouldShowLoader = true,
    bool shouldCheckInternet = true,
    bool shouldShowErrorModal = true,
  }) async {
    if (shouldShowLoader) {
      await showLoader();
    }

    if (shouldCheckInternet) {
      final isOnline = await hasInternet();
      if (!isOnline) {
        if (shouldShowLoader) closeLoader();

        if (shouldShowErrorModal) {
          _navigateToScreen(
            () => ErrorScreen(
              errorCode: '-1',
              errorMessage: appLocalization.noInternet,
            ),
          );
        }
        return;
      }
    }

    ErrorCatcher.setError(hasError: false, statusCode: null);

    try {
      await future();
    } finally {
      if (shouldShowLoader) {
        closeLoader();
      }
      final hasError = ErrorCatcher().hasError ?? false;

      if (hasError) {
        if (kDebugMode) {
          logger.e(
            'Exception From Data fetcher: ${ErrorCatcher().exception!}',
          );
        }

        if (shouldShowErrorModal) {
          _handleException(
            exception: ErrorCatcher().exception!,
            stackTrace: ErrorCatcher().stackTrace!,
            statusCode: ErrorCatcher().statusCode!,
          );
        }
      }
    }
  }

  void _handleException({
    required Exception exception,
    required StackTrace stackTrace,
    required int statusCode,
  }) {
    if (kDebugMode) {
      print('statusCode: $statusCode');
      print('Exception: $exception');
    }

    final String errorMsg = _getErrorMessage(statusCode);

    _navigateToScreen(
      () => ErrorScreen(
        errorCode: statusCode.toString(),
        errorMessage: errorMsg,
      ),
    );
  }

  void _navigateToScreen(Widget Function() screen) {
    Future.delayed(
      Duration.zero,
      () => Get.to(
        screen,
        opaque: false,
        fullscreenDialog: true,
      ),
    );
  }

  String _getErrorMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad Request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not Found';
      case 405:
        return 'Method Not Allowed';
      case 406:
        return 'Not Acceptable';
      case 408:
        return 'Request Timeout';
      case 409:
        return 'Conflict';
      case 410:
        return 'Gone';
      case 411:
        return 'Length Required';
      case 412:
        return 'Precondition Failed';
      case 413:
        return 'Payload Too Large';
      case 414:
        return 'URI Too Long';
      case 415:
        return 'Unsupported Media Type';
      case 416:
        return 'Range Not Satisfiable';
      case 417:
        return 'Expectation Failed';
      case 422:
        return 'Unprocessable Entity';
      case 429:
        return 'Too Many Requests';
      case 500:
        return 'Internal Server Error';
      case 501:
        return 'Not Implemented';
      case 502:
        return 'Bad Gateway';
      case 503:
        return 'Service Unavailable';
      case 504:
        return 'Gateway Timeout';
      default:
        return 'Unknown Error';
    }
  }

  @override
  void onClose() {
   // _messageController.close();
    // _refreshController.close();
    // _pageSateController.close();
    super.onClose();
  }
}
