import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mohan_impex/data/datasources/local_share_preference.dart';
import 'package:mohan_impex/features/splash/splash_screen.dart';
import 'package:mohan_impex/res/app_colors.dart';
import 'package:mohan_impex/res/app_router.dart';
import 'package:mohan_impex/res/loader/custom_navigtion_obserrve.dart';
import 'package:mohan_impex/utils/textfield_utils.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await LocalSharePreference().init();
  await FlutterDownloader.initialize(
      debug: true,
      ignoreSsl: true
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final CustomNavigatorObserver _navigatorObserver = CustomNavigatorObserver();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        TextfieldUtils.hideKeyboard();
      },
      child: MaterialApp(
        title: 'Mohan Impex',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
          navigatorObservers: [_navigatorObserver],
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.scaffoldBG,
          dialogTheme:const DialogTheme(
          backgroundColor: AppColors.whiteColor
        ),
        datePickerTheme: DatePickerThemeData(
          backgroundColor: AppColors.whiteColor,
        ),
        timePickerTheme: TimePickerThemeData(
          backgroundColor: AppColors.whiteColor
        ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
