import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/colors.dart';
import 'constants/theme.dart';
import 'screens/home/home_screen/home_screen.dart';
import 'screens/onboarding/getting_started_screen/getting_started_screen.dart';
import 'services/locator.dart';
import 'utils/is_dark.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupServiceLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PaperPlane',
      theme: ThemeData(
        primaryColor: primaryColorLight,
        accentColor: primaryColorLight,
        iconTheme: IconThemeData(
          color: ThemeData.light().iconTheme.color,
        ),
        textTheme: textTheme,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        pageTransitionsTheme: pageTransitionsTheme,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryColorLight,
        ),
        appBarTheme: appBarTheme.copyWith(
          brightness: Brightness.light,
          iconTheme: IconThemeData(
            color: ThemeData.light().textTheme.bodyText1.color,
          ),
        ),
        canvasColor: canvasColorLight,
        scaffoldBackgroundColor: canvasColorLight,
        bottomNavigationBarTheme:
            ThemeData.light().bottomNavigationBarTheme.copyWith(
                  backgroundColor: Colors.white,
                  elevation: 4,
                ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: primaryColorDark,
        accentColor: primaryColorDark,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        textTheme: textTheme,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        pageTransitionsTheme: pageTransitionsTheme,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryColorDark,
        ),
        appBarTheme: appBarTheme.copyWith(
          brightness: Brightness.dark,
        ),
        canvasColor: canvasColorDark,
        scaffoldBackgroundColor: canvasColorDark,
        bottomNavigationBarTheme:
            ThemeData.dark().bottomNavigationBarTheme.copyWith(
                  unselectedItemColor: Colors.white.withOpacity(0.9),
                  selectedItemColor: primaryColorDark,
                  elevation: 0,
                  backgroundColor: Color(0xff212121),
                ),
      ),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            systemNavigationBarColor:
                isDark(context) ? Color(0xff212121) : Colors.white,
            systemNavigationBarIconBrightness:
                isDark(context) ? Brightness.light : Brightness.dark,
            statusBarIconBrightness: Theme.of(context).brightness,
          ),
        );

        return child;
      },
      home: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data.containsKey("onBoardingComplete") &&
                    snapshot.data.getBool("onBoardingComplete")
                ? HomeScreen()
                : GettingStartedScreen();
          }

          return Container();
        },
      ),
    );
  }
}
