class QuestionWrapper {
  bool hasEnded = false;
  String? question;
  String? correctAnswer;
  int? correctGuessesCount;

  String? totalCorrect;
  String? timeSpent;
  String? rank;

  QuestionWrapper(
      {this.hasEnded = false,
      this.question,
      this.correctAnswer,
      this.correctGuessesCount,
      this.rank,
      this.timeSpent,
      this.totalCorrect});
}
