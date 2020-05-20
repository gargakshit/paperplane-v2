import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/colors.dart';
import 'constants/theme.dart';
import 'screens/home/home_screen/home_screen.dart';
import 'screens/onboarding/getting_started_screen/getting_started_screen.dart';
import 'services/locator.dart';

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
        bottomNavigationBarTheme:
            ThemeData.dark().bottomNavigationBarTheme.copyWith(
                  unselectedItemColor: Colors.white.withOpacity(0.9),
                  selectedItemColor: primaryColorDark,
                ),
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data.containsKey("onBoardingComplete")
                ? HomeScreen()
                : GettingStartedScreen();
          }

          return Container();
        },
      ),
    );
  }
}
