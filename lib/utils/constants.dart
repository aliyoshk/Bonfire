import '../data/models/question_model.dart';
import '../data/models/user_model.dart';

class AppConstants {
  // Animation Durations
  static const Duration fadeAnimationDuration = Duration(milliseconds: 800);
  static const Duration slideAnimationDuration = Duration(milliseconds: 600);
  static const Duration selectionAnimationDuration = Duration(milliseconds: 200);

  // Layout Constants
  static const double defaultPadding = 20.0;
  static const double smallPadding = 12.0;
  static const double profileImageSize = 48.0;
  static const double optionCircleSize = 32.0;
  static const double bottomNavButtonSize = 56.0;

  // Screen Breakpoints
  static const double smallScreenThreshold = 375.0;

  // Border Radius
  static const double defaultBorderRadius = 12.0;
  static const double smallBorderRadius = 8.0;

  // Font Sizes
  static const double titleFontSize = 36.0;
  static const double titleFontSizeSmall = 32.0;
  static const double questionFontSize = 24.0;
  static const double questionFontSizeSmall = 20.0;
  static const double bodyFontSize = 15.0;
  static const double bodyFontSizeSmall = 14.0;
  static const double captionFontSize = 14.0;
  static const double smallCaptionFontSize = 12.0;

  // Asset Paths
  static const String backgroundImagePath = 'assets/images/lake_sunset.jpg';
  static const String defaultProfileImagePath = 'assets/images/angelina_profile.jpg';

  // Sample Data
  static QuestionModel get sampleQuestion => QuestionModel(
    id: '1',
    question: 'What is your favorite time of the day?',
    userQuote: 'Mine is definitely the peace in the morning.',
    user: UserModel(
      id: '1',
      name: 'Angelina',
      age: 28,
      profileImageUrl: defaultProfileImagePath,
      location: 'New York',
    ),
    options: [
      AnswerOption(
        key: 'A',
        text: 'The peace in the early mornings',
        isSelected: true,
      ),
      AnswerOption(
        key: 'B',
        text: 'The magical golden hours',
      ),
      AnswerOption(
        key: 'C',
        text: 'Wind-down time after dinners',
      ),
      AnswerOption(
        key: 'D',
        text: 'The serenity past midnight',
        isHighlighted: true,
      ),
    ],
  );
}