import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:paperplane/constants/colors.dart';
import 'package:paperplane/screens/onboarding/gettingStarted.dart';
import 'package:paperplane/screens/home/homePage.dart';
import 'package:paperplane/models/ui/loadingModel.dart';
import 'package:paperplane/constants/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<LoadingModel> loadPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      if (prefs.getBool("onBoardingComplete")) {
        return LoadingModel(
          onboardingDone: true,
          hasPfp: prefs.getBool("hasPfp"),
          name: prefs.getString("myName"),
          pfpPath:
              join((await getApplicationDocumentsDirectory()).path, "pfp.png"),
        );
      } else {
        return LoadingModel(
          onboardingDone: false,
          hasPfp: false,
          name: "",
          pfpPath: "",
        );
      }
    } catch (e) {
      return LoadingModel(
        onboardingDone: false,
        hasPfp: false,
        name: "",
        pfpPath: "",
      );
    }
  }

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
                  unselectedIconTheme: IconThemeData(
                    color: Colors.white.withOpacity(0.9),
                  ),
                  unselectedLabelStyle: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                  ),
                  selectedIconTheme: IconThemeData(
                    color: primaryColorDark,
                  ),
                  selectedLabelStyle: TextStyle(
                    color: primaryColorDark,
                  ),
                ),
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<LoadingModel>(
        future: loadPrefs(),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.onboardingDone) {
              return HomePage(
                name: snapshot.data.name,
                hasPfp: snapshot.data.hasPfp,
                pfpPath: snapshot.data.pfpPath,
              );
            } else {
              return GettingStartedPage();
            }
          }
          return Container();
        },
      ),
    );
  }
}
