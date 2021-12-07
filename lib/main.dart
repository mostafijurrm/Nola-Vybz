import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nolavybz/screens/splash_screen.dart';
import 'package:nolavybz/utils/custom_color.dart';
import 'package:nolavybz/utils/strings.dart';

User user;

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

///root of your application, starting point of execution
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: CustomColor.primaryColor
    ));
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: () => MaterialApp(
        title: Strings.appName,
        theme: ThemeData(
          primaryColor: CustomColor.primaryColor,
        ),
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
