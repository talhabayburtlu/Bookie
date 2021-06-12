import 'package:flutter/material.dart';

const BOOK_FALLBACK_URL =
    "https://upload.wikimedia.org/wikipedia/commons/thumb/3/39/Book.svg/875px-Book.svg.png";

const Widget horizontalSpaceTiny = SizedBox(width: 5.0);
const Widget horizontalSpaceSmall = SizedBox(width: 10.0);
const Widget horizontalSpaceMedium = SizedBox(width: 25.0);

const Widget verticalSpaceTiny = SizedBox(height: 5.0);
const Widget verticalSpaceSmall = SizedBox(height: 10.0);
const Widget verticalSpaceMedium = SizedBox(height: 25.0);
const Widget verticalSpaceLarge = SizedBox(height: 40.0);
const Widget verticalSpaceMassive = SizedBox(height: 120.0);

const double FONT_SIZE_MEDIUM = 18;
const double FONT_SIZE_LARGE = 20;
const Color backgroundColor = const Color(0xfffafafa);
const Color blue = const Color(0xff677fff);
const Color darkGrey = const Color(0xff4b515c);
const Color red = const Color(0xfff44336);

Widget spacedDivider = Column(
  children: const <Widget>[
    verticalSpaceMedium,
    const Divider(color: Colors.blueGrey, height: 5.0),
    verticalSpaceMedium,
  ],
);

Widget verticalSpace(double height) => SizedBox(height: height);

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;

double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double screenHeightFraction(BuildContext context,
        {int dividedBy = 1, double offsetBy = 0}) =>
    (screenHeight(context) - offsetBy) / dividedBy;

double screenWidthFraction(BuildContext context,
        {int dividedBy = 1, double offsetBy = 0}) =>
    (screenWidth(context) - offsetBy) / dividedBy;

double halfScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 2);

double thirdScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 3);

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  static double pixelRatio;
  static double screenWidthPixel;
  static double screenHeightPixel;

  static Widget verticalSpace(double percentage) {
    return SizedBox(
      height: SizeConfig.blockSizeVertical * percentage,
    );
  }

  static Widget horizontalSpace(double percentage) {
    return SizedBox(
      width: SizeConfig.blockSizeHorizontal * percentage,
    );
  }

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    pixelRatio = _mediaQueryData.devicePixelRatio;
    screenWidthPixel = screenWidth * pixelRatio;
    screenHeightPixel = screenHeight * pixelRatio;
  }
}
