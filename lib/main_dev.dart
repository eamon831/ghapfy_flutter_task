import '/app/core/exporter.dart';

import '/app/my_app.dart';
import '/flavors/env_config.dart';
import '/flavors/environment.dart';
import 'app/bindings/initial_binding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// uncomment below 2 lines to set the orientation of the app
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final devConfig = EnvConfig(
    appName: 'Ghapfy Flutter Task',
    baseUrl: 'https://fakestoreapi.com/',
    shouldCollectCrashLog: true,
  );

  BuildConfig.instantiate(
    envType: Environment.development,
    envConfig: devConfig,
  );

  await InitialBinding().dependencies();
  final prefs = SessionManager();
  final lang = await prefs.getString(prefLanguage) ?? 'en';

  runApp(
    MyApp(
      lang: lang,
    ),
  );
}
