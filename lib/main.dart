import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lost_tracking/providers/auth_provider.dart';
import 'package:lost_tracking/screens/sms.dart';
import 'package:provider/provider.dart';
import './services/navigation_service.dart';
import './utils/routes.dart';
import './utils/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) =>
    MyApp(),
    //),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthProvider(),
        ),
      ],
      child: MaterialApp(
        builder: DevicePreview.appBuilder,
        title: 'Lost Tracking App',
        color: Theme.of(context).backgroundColor,
        debugShowCheckedModeBanner: false,
        locale: DevicePreview.locale(context),
        navigatorKey: locator<NavigationService>().navigatorKey,
        theme: ThemeData(
          backgroundColor: Color.fromRGBO(7, 29, 89, 1),
          primaryColor: Color.fromRGBO(7, 29, 89, 1),
          accentColor: Color.fromRGBO(226, 0, 1, 1),
          visualDensity: VisualDensity.adaptivePlatformDensity,

          // Define the default font family.
          fontFamily: 'Poppins',
        ),
        onGenerateRoute: onGenerateRoute,
        initialRoute: SplashScreenRoute,
        // home: MyApp1(),
      ),
    );
  }
}
