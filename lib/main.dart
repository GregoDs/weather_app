import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_now/home/ui/home_screen.dart';
import 'package:weather_now/home/cubit/weather_cubit.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import the dotenv package

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Make sure Flutter is ready before loading
  //await dotenv.load(fileName: ".env"); // Load environment variables
  runApp(
    const OverlaySupport(child: MainApp()),
  ); // Show notifications or alerts over the app
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.blue,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
          ),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<WeatherCubit>(
                create: (context) => WeatherCubit(),
              ),
            ],
            child: MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false, // Make check mode banner disappear
              home: const HomeScreen(),
            ),
          ),
        );
      },
    );
  }
}