class QuizQuestionModel{

  // unique identifier
  late int id;

  late String title;

  late List<String> answers;

  late int correctAnswerIndex;

  QuizQuestionModel({
    required this.id,
    required this.answers,
    required this.title,
    required this.correctAnswerIndex,
  });
}