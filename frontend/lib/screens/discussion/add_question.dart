import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../providers/user_provider.dart';
import '../../services/discussion_service.dart';

class AddQuestion extends StatefulWidget {
  const AddQuestion({Key? key}) : super(key: key);

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  String name = "";
  String description = "";
  String error = "";
  bool loading = false;

  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ask A Question',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                const SizedBox(height: 30),
                SizedBox(
                  width: 320,
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    onChanged: (value) {
                      name = value.trim().toString();
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      suffixIcon: Icon(Icons.title),
                      hintText: 'Enter Title of Question',
                      labelText: 'Title',
                    ),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Please Enter Title of Question';
                      }
                      // else if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                      //     .hasMatch(name)) {
                      //   return 'Please! Enter Product Name';
                      // }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: 320,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      description = value.trim().toString();
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      suffixIcon: Icon(Icons.description),
                      hintText: 'Describe your Question in Detail',
                      labelText: 'Description',
                    ),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Please Enter Your Question Description';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    FloatingActionButton.extended(
                      label: const Text('Add Question'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => loading = true);
                          var result = await createQuestion(
                              name,
                              description,
                              userProvider.users.first.uid,
                              DateFormat("yyyy-MM-dd hh:mm:ss")
                                  .format(DateTime.now()));
                          // ignore: unnecessary_null_comparison
                          if (result == null) {
                            setState(() {
                              error = 'Could not Add Category';
                              loading = false;
                            });
                          } else {
                            // ignore: avoid_print
                            print("Product Added: CID is : " + result.id);
                            Alert(
                              context: context,
                              type: AlertType.success,
                              title: "Added",
                              desc: "Question Added Successfully",
                              buttons: [
                                DialogButton(
                                  child: const Text(
                                    "Okay",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                  width: 120,
                                )
                              ],
                            ).show();
                          }
                        }
                      },
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                const SizedBox(height: 30),
                if (error.isEmpty == false)
                  Center(
                      child: Text(
                    error,
                    style: const TextStyle(color: Colors.red),
                  )),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
