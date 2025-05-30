import 'package:flutter/cupertino.dart';
import 'constants.dart';


class ResponsiveUtils {
  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < AppConstants.smallScreenThreshold;
  }

  static double getTitleFontSize(BuildContext context) {
    return isSmallScreen(context)
        ? AppConstants.titleFontSizeSmall
        : AppConstants.titleFontSize;
  }

  static double getQuestionFontSize(BuildContext context) {
    return isSmallScreen(context)
        ? AppConstants.questionFontSizeSmall
        : AppConstants.questionFontSize;
  }

  static double getBodyFontSize(BuildContext context) {
    return isSmallScreen(context)
        ? AppConstants.bodyFontSizeSmall
        : AppConstants.bodyFontSize;
  }

  static EdgeInsets getDefaultPadding(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: AppConstants.defaultPadding,
      vertical: isSmallScreen(context)
          ? AppConstants.smallPadding
          : AppConstants.defaultPadding,
    );
  }
}