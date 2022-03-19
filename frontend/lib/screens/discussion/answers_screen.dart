import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../models/answer.dart';
import '../../models/question.dart';
import '../../providers/user_provider.dart';
import '../../services/discussion_service.dart';

class AnswersScreen extends StatefulWidget {
  static const routeName = '/answers';

  const AnswersScreen({Key? key}) : super(key: key);

  @override
  State<AnswersScreen> createState() => _AnswersScreenState();
}

class _AnswersScreenState extends State<AnswersScreen> {
  final _formKey = GlobalKey<FormState>();
  String reply = "";
  late Future<List<Answer>> futureAnswers;
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final loadedQuestion =
        ModalRoute.of(context)!.settings.arguments as Question; // is the id
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discussion'),
      ),
      // drawer: const MainDrawer(),
      body: FutureBuilder(
        future: futureAnswers,
        builder: (context, snapshot) {
          if (snapshot.hasData == false) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          try {
            // List<String> ansIds = loadedQuestion.answers;
            // one question can have many answers
            // (snapshot.data as List<Answer>)
            //     .removeWhere((element) => !ansIds.contains(element.id));
            // one answer belongs to one question
            (snapshot.data as List<Answer>)
                .removeWhere((element) => element.qid != loadedQuestion.id);
          } catch (e) {
            // ignore: avoid_print
            print(e.toString());
          }
          return Stack(
            children: [
              buildQuestionItem(loadedQuestion, snapshot),
              Positioned(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 0,
                right: 0,
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 50,
                    child: Row(children: [
                      Expanded(
                          child: TextFormField(
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.name,
                        onChanged: (value) {
                          reply = value.toString();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Answer';
                          }
                          return null;
                        },
                      )),
                      TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              var result = await createAnswer(
                                  reply,
                                  userProvider.users.first.uid,
                                  DateFormat("yyyy-MM-dd hh:mm:ss")
                                      .format(DateTime.now())
                                      .toString(),
                                  loadedQuestion.id);
                              // ignore: unnecessary_null_comparison
                              if (result == null) {
                                // setState(() {
                                //   error = 'Could not Add Category';
                                //   loading = false;
                                // });
                              } else {
                                // ignore: avoid_print
                                print("Answer Added: CID is : " + result.id);
                                setState(() {
                                  futureAnswers = fetchAnswers();
                                  reply = "";
                                });
                              }
                            }
                          },
                          child: const Icon(
                            Icons.send,
                            color: Colors.black,
                          ))
                    ]),
                    decoration: const BoxDecoration(color: Colors.orange),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildQuestionItem(Question question, snapshot) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(question.title),
            subtitle: Text(question.description),
            trailing: Text(question.datetime),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: (snapshot.data as List<Answer>).length,
                  itemBuilder: (BuildContext context, int index) {
                    // getting each order and sending it to the widget for building order item
                    return buildAnswerItem(
                        (snapshot.data as List<Answer>)[index]);
                  })),
        ],
      ),
    );
  }

  Widget buildAnswerItem(Answer answer) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(answer.reply),
            subtitle: Text(answer.datetime),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    futureAnswers = fetchAnswers();
  }
}
