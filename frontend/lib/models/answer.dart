class Answer {
  final String id;
  final String reply;
  final String uid;
  final String datetime;
  final String qid;

  const Answer(
      {required this.id,
      required this.reply,
      required this.uid,
      required this.datetime,
      required this.qid});

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
        id: json['id'],
        reply: json['reply'],
        uid: json['uid'],
        datetime: json['datetime'],
        qid: json['qid']);
  }
  static List<Answer> fromListJson(List<dynamic> json) {
    List<Answer> result = <Answer>[];
    for (Map<String, dynamic> d in json) {
      result.add(Answer.fromJson(d));
    }
    return result;
  }
}
