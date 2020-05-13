import 'package:animations/animations.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:paperplane/constants/colors.dart';
import 'package:paperplane/screens/onboarding/gettingStarted.dart';
import 'package:paperplane/screens/home/homePage.dart';
import 'package:paperplane/models/ui/loadingModel.dart';

void main() {
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
              join((await getApplicationDocumentsDirectory()).path, "pfp.jpg"),
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
    return DynamicTheme(
      defaultBrightness: WidgetsBinding.instance.window.platformBrightness,
      data: (brightness) => ThemeData(
        primaryColor: brightness == Brightness.light
            ? primaryColorLight
            : primaryColorDark,
        accentColor: brightness == Brightness.light
            ? primaryColorLight
            : primaryColorDark,
        iconTheme: IconThemeData(
          color: brightness == Brightness.light
              ? ThemeData.light().iconTheme.color
              : Colors.white,
        ),
        brightness: brightness,
        textTheme: TextTheme(
          headline1: GoogleFonts.robotoCondensed(
            fontSize: 96,
            fontWeight: FontWeight.w300,
            letterSpacing: -1.5,
          ),
          headline2: GoogleFonts.robotoCondensed(
            fontSize: 60,
            fontWeight: FontWeight.w300,
            letterSpacing: -0.5,
          ),
          headline3: GoogleFonts.robotoCondensed(
            fontSize: 48,
            fontWeight: FontWeight.w400,
          ),
          headline4: GoogleFonts.robotoCondensed(
            fontSize: 34,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.25,
          ),
          headline5: GoogleFonts.robotoCondensed(
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
          headline6: GoogleFonts.robotoCondensed(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.15,
          ),
          subtitle1: GoogleFonts.robotoCondensed(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.15,
          ),
          subtitle2: GoogleFonts.robotoCondensed(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.1,
          ),
          bodyText2: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
          ),
          bodyText1: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.25,
          ),
          button: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.25,
          ),
          caption: GoogleFonts.roboto(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.4,
          ),
          overline: GoogleFonts.roboto(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.5,
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        pageTransitionsTheme: PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: SharedAxisPageTransitionsBuilder(
              transitionType: SharedAxisTransitionType.horizontal,
            ),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          title: 'PaperPlane',
          theme: theme,
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
      },
    );
  }
}
