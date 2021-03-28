import 'package:flutter/material.dart';
import 'package:persona/size_config.dart';

// clolors that we use in our app
const kMainColor = Color(0xFF9297FF);
const kActiveColor = Colors.white;
const kBodyTextColor = Color(0xFF707070);
const kBgColor = Colors.white;

// Text Styles
final TextStyle kH1TextStyle = TextStyle(
  fontFamily: 'NotoSans',
  fontSize: getProportionateScreenWidth(34),
  fontWeight: FontWeight.w500,
  letterSpacing: 0.22,
);

final TextStyle kH2TextStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.w600,
  letterSpacing: 0.18,
);

final TextStyle kH3TextStyle = kH2TextStyle.copyWith(
  fontSize: getProportionateScreenWidth(20),
  letterSpacing: 0.14,
);

final TextStyle kHeadlineTextStyle = TextStyle(
  fontFamily: 'NotoSans',
  fontSize: 17,
  color: kMainColor,
  fontWeight: FontWeight.bold,
);

final TextStyle kSubHeadTextStyle = TextStyle(
  fontSize: getProportionateScreenWidth(18),
  fontWeight: FontWeight.w500,
  color: kMainColor,
  letterSpacing: 0.44,
);

final TextStyle kBodyTextStyle = TextStyle(
  fontSize: 15,
  color: kBodyTextColor,
  //height: 1.5,
);

final TextStyle kSecondaryBodyTextStyle = TextStyle(
  fontSize: getProportionateScreenWidth(14),
  fontWeight: FontWeight.w500,
  color: kMainColor,
  // height: 1.5,
);

final TextStyle kButtonTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 13,
  fontWeight: FontWeight.bold,
);

final TextStyle kCaptionTextStyle = TextStyle(
  color: kMainColor.withOpacity(0.64),
  fontSize: getProportionateScreenWidth(12),
  fontWeight: FontWeight.w600,
);

// padding
const double kDefaultPadding = 40.0;
final EdgeInsets kTextFieldPadding = EdgeInsets.symmetric(
  horizontal: kDefaultPadding,
  vertical: getProportionateScreenHeight(kDefaultPadding),
);
