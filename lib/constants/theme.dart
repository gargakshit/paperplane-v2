import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme textTheme = TextTheme(
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
);

PageTransitionsTheme pageTransitionsTheme = PageTransitionsTheme(
  builders: <TargetPlatform, PageTransitionsBuilder>{
    TargetPlatform.android: SharedAxisPageTransitionsBuilder(
      transitionType: SharedAxisTransitionType.horizontal,
    ),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
  },
);

AppBarTheme appBarTheme = AppBarTheme(
  color: Colors.transparent,
  elevation: 0,
);
