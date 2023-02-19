import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionPaperModel {
  String id;
  String title;
  String imageUrl;
  String description;
  int timeSeconds;
  List<Questions>? questions;
  int questionCount;

  QuestionPaperModel(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.description,
      required this.timeSeconds,
      required this.questionCount,
      this.questions});

  QuestionPaperModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        title = json['title'] as String,
        imageUrl = json['image_url'] as String,
        description = json['description'] as String,
        timeSeconds = json['time_seconds'],
        questionCount = 0,
        questions = (json['questions'] as List)
            .map((dynamic e) => Questions.fromJson(e as Map<String, dynamic>))
            .toList();

  QuestionPaperModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json)
      : id = json.id,
        title = json['title'],
        imageUrl = json['image_url'],
        description = json['description'],
        timeSeconds = json['time_seconds'],
        questionCount = json['questions_count'] as int,
        questions = [];

  String timeInMinutes() => "${(timeSeconds / 60).ceil()} mins";

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image_url'] = this.imageUrl;
    data['description'] = this.description;
    data['time_seconds'] = this.timeSeconds;

    return data;
  }
}

class Questions {
  String id;
  String question;
  List<Answers> answers;
  String? correctAnswer;
  String? selectedAnswer;

  Questions(
      {required this.id,
      required this.question,
      required this.answers,
      this.correctAnswer});

  Questions.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        question = json['question'],
        answers =
            (json['answers'] as List).map((e) => Answers.fromJson(e)).toList(),
        correctAnswer = json['correct_answer'];

  Questions.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        question = snapshot['question'],
        answers = [],
        correctAnswer = snapshot['correct_answer'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    if (this.answers != null) {
      data['answers'] = this.answers.map((v) => v.toJson()).toList();
    }
    data['correct_answer'] = this.correctAnswer;
    return data;
  }
}

class Answers {
  String? identifier;
  String? answer;

  Answers({this.identifier, this.answer});

  Answers.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    answer = json['Answer'];
  }

  Answers.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : identifier = snapshot['identifier'] as String?,
        answer = snapshot['answer'] as String?;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identifier'] = this.identifier;
    data['Answer'] = this.answer;
    return data;
  }
}
