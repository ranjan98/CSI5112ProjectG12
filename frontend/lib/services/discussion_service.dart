import 'dart:async';
import 'dart:convert';
import 'package:frontend/models/answer.dart';
import 'package:frontend/models/question.dart';
import 'package:http/http.dart' as http;

Future<Question> createQuestion(
    String title, String description, String uid, String datetime) async {
  final responseGet =
      await http.get(Uri.parse('https://service.uomart.net/api/Questions/'));
  var total = 0;
  if (responseGet.statusCode == 200) {
    var questions = Question.fromListJson(jsonDecode(responseGet.body));
    total = questions.length;
    // post the data to backend - send http post request
    final response = await http.post(
      Uri.parse(
        'https://service.uomart.net/api/Questions/',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': (total + 1).toString(),
        'title': title,
        'description': description,
        'uid': uid,
        'answers': [],
        'datetime': datetime
      }),
    );

    if (response.statusCode == 201) {
      return Question.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to submit the question. Please try later');
    }
  } else {
    throw Exception('Failed to submit the question');
  }
}

Future<List<Question>> fetchQuestions() async {
  final response =
      await http.get(Uri.parse('https://service.uomart.net/api/Questions/'));

  if (response.statusCode == 200) {
    return Question.fromListJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to get questions data');
  }
}

Future<Question> fetchQuestion(String id) async {
  final response = await http
      .get(Uri.parse('https://service.uomart.net/api/Questions/' + id));

  if (response.statusCode == 200) {
    return Question.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to get the question data');
  }
}

Future<Answer> createAnswer(
    String reply, String uid, String datetime, String qid) async {
  final responseGet =
      await http.get(Uri.parse('https://service.uomart.net/api/Answers/'));
  var total = 0;
  if (responseGet.statusCode == 200) {
    var questions = Answer.fromListJson(jsonDecode(responseGet.body));
    total = questions.length;
    // post the data to backend - send http post request
    final response = await http.post(
      Uri.parse(
        'https://service.uomart.net/api/Answers/',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': (total + 1).toString(),
        'reply': reply,
        'uid': uid,
        'datetime': datetime,
        'qid': qid
      }),
    );

    if (response.statusCode == 201) {
      return Answer.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to submit the question. Please try later');
    }
  } else {
    throw Exception('Failed to submit the question');
  }
}

Future<List<Answer>> fetchAnswers() async {
  final response =
      await http.get(Uri.parse('https://service.uomart.net/api/Answers/'));

  if (response.statusCode == 200) {
    return Answer.fromListJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to get questions data');
  }
}

Future<Answer> fetchAnswer(String id) async {
  final response =
      await http.get(Uri.parse('https://service.uomart.net/api/Answers/' + id));

  if (response.statusCode == 200) {
    return Answer.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to get the question data');
  }
}
