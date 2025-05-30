import '../../utils/constants.dart';
import '../models/question_model.dart';

class QuestionService {
  static final QuestionService _instance = QuestionService._internal();
  factory QuestionService() => _instance;
  QuestionService._internal();

  Future<QuestionModel> getCurrentQuestion() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return AppConstants.sampleQuestion;
  }

  Future<bool> submitAnswer(String questionId, String selectedOption) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }

  Future<QuestionModel?> getNextQuestion() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return null;
  }
}