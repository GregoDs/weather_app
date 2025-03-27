import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:weather_now/home/ui/home_screen.dart';

void main(dynamic dotenv) async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized(); //Make sure flutter is ready before loading
  runApp(
    const OverlaySupport(child: MainApp()),
  ); //show notifications or alerts over the app
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.blue,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
          ),
          child: MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner:
                false, //  make check mode banner dissapear
            home: HomeScreen(),
          ),
        );
      },
    );
  }
}
