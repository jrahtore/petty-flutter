// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:petty_app/screens/splashscreen.dart';
import 'package:petty_app/services/online_status.dart';
import 'package:petty_app/utils/constant.dart';

Future<void> main() async {
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.white,
  //   // systemNavigationBarIconBrightness:
  // ));
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  // Stripe.publishableKey = 'pk_test_ZgYrPNmOEfvgg086lwWOrUn8';
  Stripe.publishableKey = 'pk_live_AtB9oIn1niL4wLx8QrI7i0O1';
  Stripe.merchantIdentifier = 'petty';
  await Stripe.instance.applySettings();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  await Firebase.initializeApp();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // This widget is the root of your application.

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.paused) {
      UpdateOnlineOffline().updateIAmOffline();
    } else if (state == AppLifecycleState.resumed) {
      UpdateOnlineOffline().updateIAmOnline();
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // routes: {
      //   '/wrapper': (context) => Wrapper(),
      // },
      color: Color(textColor),
      theme: ThemeData(
        primaryColor: Color(textColor),
        primarySwatch: Colors.indigo,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Color(textColor),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'Petty',

      home: SplashScreen(),
      // home: Category(),
    );
  }
}
