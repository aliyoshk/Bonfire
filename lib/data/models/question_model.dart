import 'package:bonfire/data/models/user_model.dart';

class QuestionModel {
  final String id;
  final String question;
  final String userQuote;
  final List<AnswerOption> options;
  final UserModel user;

  QuestionModel({
    required this.id,
    required this.question,
    required this.userQuote,
    required this.options,
    required this.user,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] ?? '',
      question: json['question'] ?? '',
      userQuote: json['userQuote'] ?? '',
      options: (json['options'] as List<dynamic>?)
          ?.map((option) => AnswerOption.fromJson(option))
          .toList() ?? [],
      user: UserModel.fromJson(json['user'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'userQuote': userQuote,
      'options': options.map((option) => option.toJson()).toList(),
      'user': user.toJson(),
    };
  }
}

class AnswerOption {
  final String key;
  final String text;
  final bool isHighlighted;
  final bool isSelected;

  AnswerOption({
    required this.key,
    required this.text,
    this.isHighlighted = false,
    this.isSelected = false,
  });

  factory AnswerOption.fromJson(Map<String, dynamic> json) {
    return AnswerOption(
      key: json['key'] ?? '',
      text: json['text'] ?? '',
      isHighlighted: json['isHighlighted'] ?? false,
      isSelected: json['isSelected'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'text': text,
      'isHighlighted': isHighlighted,
      'isSelected': isSelected,
    };
  }

  AnswerOption copyWith({
    String? key,
    String? text,
    bool? isHighlighted,
    bool? isSelected,
  }) {
    return AnswerOption(
      key: key ?? this.key,
      text: text ?? this.text,
      isHighlighted: isHighlighted ?? this.isHighlighted,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}