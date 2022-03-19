import 'package:flutter/material.dart';
import '../../models/question.dart';
import '../../services/discussion_service.dart';

class QuestionsScreen extends StatefulWidget {
  static const routeName = '/questions';

  const QuestionsScreen({Key? key}) : super(key: key);

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  late Future<List<Question>> futureQuestions;

  // removed the static data for orders and fetching from backend
  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);
    // final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discussion'),
      ),
      // drawer: const MainDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed('/add-question').then((value) {
            setState(() {
              futureQuestions = fetchQuestions();
            });
          });
        },
        label: const Text('Ask A Question'),
        icon: const Icon(
          Icons.add_circle_outline,
          color: Colors.black,
        ),
      ),
      body: FutureBuilder(
        future: futureQuestions,
        builder: (context, snapshot) {
          if (snapshot.hasData == false) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          return ListView.builder(
              itemCount: (snapshot.data as List<Question>).length,
              itemBuilder: (BuildContext context, int index) {
                // getting each order and sending it to the widget for building order item
                return buildQuestionItem(
                    (snapshot.data as List<Question>)[index]);
              });
        },
      ),
    );
  }

  Widget buildQuestionItem(Question question) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/answers', arguments: question);
      },
      child: Card(
        elevation: 5,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 10),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(question.title),
                subtitle: Text(question.description),
                trailing: Text(question.datetime),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    futureQuestions = fetchQuestions(); // fetch the questions
  }
}
