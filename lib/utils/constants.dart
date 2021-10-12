import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Spacing
const double kPadding = 5;
const double kSmallPadding = 10;
const double kRegularPadding = 15;
const double kMediumPadding = 20;
const double kLargePadding = 40;
const double kFullPadding = 60;
const double kWidthRatio = 0.9;
const double kIconSize = 24;
double kCalculatedWidth(Size size) => size.width * kWidthRatio;
double kCalculatedMargin(Size size) => size.width * (1 - kWidthRatio) / 2;

// Colors
const Color kPrimaryColor = Color(0xff003f7f);
const Color kPrimaryTextColor = Colors.black;
const Color kTranPrimaryColor =Colors.black45;
const Color kSecondaryTextColor = Colors.white;
const Color kScaffoldBackgroundColor = Color(0xffF9F9F9);
final Color kBorderColor = Colors.grey[350];
final Color kSubtextColor = Color(0xff9A9A9B);
final Color kColorGrey = Colors.grey[300];


// Border
const double kBorderWidth = 1;
const double kThickBorderWidth = 1;
const BorderRadius kBorderRadius =
    BorderRadius.all(const Radius.circular(kPadding));
const BorderRadius kFullBorderRadius =
    BorderRadius.all(const Radius.circular(100));
final BoxDecoration kTextFieldBoxDecoration = BoxDecoration(
    borderRadius: kBorderRadius, border: null, color: Colors.white);
BoxDecoration kRoundedEdgesBoxDecoration(
        {Color backgroundColor,
        Color shadowColor,
        Color borderColor,
        double borderWidth = kThickBorderWidth,
        double radius = kSmallPadding}) =>
    BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        border: borderColor != null
            ? Border.all(color: borderColor, width: borderWidth)
            : null,
        boxShadow: shadowColor != null ? [kBoxShadow(shadowColor)] : null,
        color: backgroundColor ?? kScaffoldBackgroundColor);
final BoxDecoration kButtonBoxDecoration = BoxDecoration(
    borderRadius: kFullBorderRadius, border: Border.all(color: kPrimaryColor));
final BoxDecoration kBottomSheetBoxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: new BorderRadius.only(
    topLeft: const Radius.circular(25.0),
    topRight: const Radius.circular(25.0),
  ),
);
BoxShadow kBoxShadow(Color color) => BoxShadow(
      color: color,
      spreadRadius: 0,
      blurRadius: 5,
      offset: Offset(0, 2), // changes position of shadow
    );

// Text
final TextStyle kHeadline1TextStyle = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
  color: kPrimaryTextColor,
  fontFamily: "Gelion",
);
final TextStyle kHeadline2TextStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  fontFamily: "Gelion",
  color: kPrimaryTextColor,
);
final TextStyle kHeadline3TextStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w500,
  fontFamily: "Gelion",
  color: kPrimaryTextColor,
);
final TextStyle kBodyText1Style = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  fontFamily: "Gelion",
  color: kPrimaryTextColor,
);
final TextStyle kBodyText2Style = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.normal,
  fontFamily: "Gelion",
  color: kPrimaryTextColor,
);
final TextStyle kSubtitle1Style = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.normal,
  fontFamily: "Gelion",
  color: kSubtextColor,
);
final TextStyle kSubtitle2Style = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w300,
  fontFamily: "Gelion",
  color: kSubtextColor,
);
String kPriceFormatter(double price) =>
    ' \$' + NumberFormat("#,##0.00", "en_US").format(price);
List kBuilderName(String name) => name.split(' ') ?? "";

// Theme
final ThemeData kThemeData = ThemeData.light().copyWith(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: kScaffoldBackgroundColor,
    dividerColor: kBorderColor,
    canvasColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      color: kPrimaryColor,
      brightness: Brightness.light,
      elevation: 0,
      textTheme: TextTheme(
        headline1: kHeadline1TextStyle,
        headline2: kHeadline2TextStyle,
        headline3: kHeadline3TextStyle,
        bodyText1: kBodyText1Style,
        bodyText2: kBodyText2Style,
        subtitle1: kSubtitle1Style,
        subtitle2: kSubtitle2Style,
      ),
      iconTheme: IconThemeData(size: kIconSize),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    iconTheme: IconThemeData(size: kIconSize),
    textTheme: TextTheme(
      headline1: kHeadline1TextStyle,
      headline2: kHeadline2TextStyle,
      headline3: kHeadline3TextStyle,
      bodyText1: kBodyText1Style,
      bodyText2: kBodyText2Style,
      subtitle1: kSubtitle1Style,
      subtitle2: kSubtitle2Style,
    ));

final ThemeData kThemeDataDark = ThemeData.dark().copyWith(
    primaryColor: kPrimaryColor,
    primaryColorDark: kPrimaryTextColor,
    primaryColorLight: kSecondaryTextColor,
    scaffoldBackgroundColor: Colors.grey[900],
    dividerColor: kBorderColor,
    canvasColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      color: kPrimaryTextColor,
      brightness: Brightness.dark,
      elevation: 0,
      textTheme: TextTheme(
        headline1: kHeadline1TextStyle.copyWith(color: Colors.white),
        headline2: kHeadline2TextStyle.copyWith(color: Colors.white),
        headline3: kHeadline3TextStyle.copyWith(color: Colors.white),
        bodyText1: kBodyText1Style.copyWith(color: Colors.white),
        bodyText2: kBodyText2Style.copyWith(color: Colors.white),
        subtitle1: kSubtitle1Style.copyWith(color: Colors.white),
        subtitle2: kSubtitle2Style.copyWith(color: Colors.white),
      ),
      iconTheme: IconThemeData(size: kIconSize),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    iconTheme: IconThemeData(size: kIconSize),
    textTheme: TextTheme(
      headline1: kHeadline1TextStyle.copyWith(color: Colors.white),
      headline2: kHeadline2TextStyle.copyWith(color: Colors.white),
      headline3: kHeadline3TextStyle.copyWith(color: Colors.white),
      bodyText1: kBodyText1Style.copyWith(color: Colors.white),
      bodyText2: kBodyText2Style.copyWith(color: Colors.white),
      subtitle1: kSubtitle1Style.copyWith(color: Colors.white),
      subtitle2: kSubtitle2Style.copyWith(color: Colors.white),
    ));
