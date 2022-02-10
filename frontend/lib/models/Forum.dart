import 'comment.dart';
import 'package:flutter/material.dart';

class Forum extends StatefulWidget {
  const Forum({Key? key}) : super(key: key);

  @override
  _ForumState createState() => _ForumState();
}

class _ForumState extends State<Forum> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  List filedata = [
    {'name': 'Ranjan Goyal', 'pic': '', 'message': 'This is not good'},
    {'name': 'Ashish', 'pic': '', 'message': 'So True'},
    {'name': 'Hari', 'pic': '', 'message': 'It was good'},
    {'name': 'John', 'pic': '', 'message': 'Okayish'},
  ];

  Widget commentChild(data) {
    return ListView(
      children: [
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  // print("Comment Clicked");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(data[i]['pic'])),
                ),
              ),
              title: Text(
                data[i]['name'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data[i]['message']),
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Discussion Forum"),
        backgroundColor: Colors.orange,
      ),
      body: CommentBox(
        userImage: "", //user image
        child: commentChild(filedata),
        labelText: 'Write a comment...',
        errorText: 'Comment cannot be blank',
        withBorder: false,
        sendButtonMethod: () {
          if (formKey.currentState!.validate()) {
            // print(commentController.text);
            setState(() {
              var value = {
                'name':
                    'New User', //ranjan add the name of the user here from database
                'pic': '', //user image
                'message': commentController.text
              };
              filedata.insert(0, value);
            });
            commentController.clear();
            FocusScope.of(context).unfocus();
          } else {
            // print("Not validated");
          }
        },
        formKey: formKey,
        commentController: commentController,
        backgroundColor: Colors.orange,
        textColor: Colors.white,
        sendWidget: const Icon(Icons.send_sharp, size: 30, color: Colors.white),
      ),
    );
  }
}
