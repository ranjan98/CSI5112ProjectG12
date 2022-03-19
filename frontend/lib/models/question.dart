class Question {
  final String id;
  final String title;
  final String description;
  final String uid;
  final List<String> answers;
  final String datetime;

  const Question(
      {required this.id,
      required this.title,
      required this.description,
      required this.uid,
      required this.answers,
      required this.datetime});

  factory Question.fromJson(Map<String, dynamic> json) {
    // List<dynamic> dynamicAns = json['answers'];
    // print((json['answers']).toString());
    // List<String> stringAns = [];
    // dynamicAns.map((e) {
    //   stringAns.add(e.toString());
    // });
    return Question(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        uid: json['uid'],
        answers: fromListJsonAnswers(json[
            'answers']), // did this to convert List<dynamic> into List<String>
        datetime: json['datetime']);
  }
  static List<String> fromListJsonAnswers(List<dynamic> json) {
    List<String> result = <String>[];
    for (dynamic d in json) {
      result.add(d as String);
    }
    return result;
  }

  static List<Question> fromListJson(List<dynamic> json) {
    List<Question> result = <Question>[];
    for (Map<String, dynamic> d in json) {
      result.add(Question.fromJson(d));
    }
    return result;
  }
}
