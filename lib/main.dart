import 'package:espitaliaa_doctors/getx/general_data_controller.dart';
import 'package:espitaliaa_doctors/pages/splash/splash_screen.dart';
import 'package:espitaliaa_doctors/utils/app_localization.dart';
import 'package:espitaliaa_doctors/utils/consts.dart';
import 'package:espitaliaa_doctors/utils/dimensions.dart';
import 'package:espitaliaa_doctors/utils/firebase_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // ensure widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();
  await FireBaseCongigFile().config();

  /* services.SystemChrome.setPreferredOrientations([
    services.DeviceOrientation.landscapeRight,
    services.DeviceOrientation.landscapeLeft,
  ]);*/
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setState(() {
      state._locale = locale;
    });
  }

  static void resetApp(BuildContext context) {
    context.findAncestorStateOfType<_MyAppState>().restartApp();
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  final GeneralDataController _generalDataController = Get.put(GeneralDataController());
  Key key = UniqueKey();
  @override
  void initState() {
    super.initState();
    _initCache();

    /// init general Data
    _generalDataController.initData();
  }

  _initCache() async {
    await SharedPreferences.getInstance().then((pref) {
      String langCode = pref.getString('lang');
      if (langCode != null) {
        _locale = Locale(langCode);
        if (mounted) setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StyledToast(
      textStyle: TextStyle(fontSize: 16.0, color: Colors.white),
      backgroundColor: Color(0x99000000),
      borderRadius: BorderRadius.circular(5.0),
      textPadding: EdgeInsets.symmetric(horizontal: 17.0, vertical: 10.0),
      toastAnimation: StyledToastAnimation.slideFromLeft,
      toastPositions: StyledToastPosition.top,
      reverseAnimation: StyledToastAnimation.slideFromRight,
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.fastLinearToSlowEaseIn,
      dismissOtherOnShow: true,
      locale: _locale ?? Locale("ar"),
      child: GetMaterialApp(
        key: key,
        debugShowCheckedModeBanner: false,
        title: 'الإسبتالية',
        supportedLocales: supportedLanguages,
        // These delegates make sure that the localization data for the proper language is loaded
        localizationsDelegates: const [
          // A class which loads the translations from JSON files
          AppLocalizations.delegate,
          // Built-in localization of basic text for Material widgets
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate, // Here !

          // Built-in localization for text direction LTR/RTL
          GlobalWidgetsLocalizations.delegate,
        ],
        locale: _locale,
        // the current saved local (use system language case no preference language used)
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'appFont',
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            brightness: Brightness.light,
            color: mainColor,
          ),
        ),
        home: LaunchPage(),
        builder: (ctx, child) {
          return Directionality(
            textDirection: Localizations.localeOf(ctx).languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
            child: child,
          );
        },
      ),
    );
  }

  void restartApp() {
    setState(() {
      key = UniqueKey();
      // context.findAncestorStateOfType<_MyAppState>().restartApp();
    });
  }
}

class LaunchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Dimensions.width = MediaQuery.of(context).size.width;
    Dimensions.height = MediaQuery.of(context).size.height;
    Dimensions.orientation = MediaQuery.of(context).orientation;
    return ScreenUtilInit(
      designSize: Size(size.width, size.height),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => SplashScreen(),
    );
  }
}
