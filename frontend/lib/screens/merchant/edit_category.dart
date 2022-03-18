import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../models/category.dart';
import '../../services/categories_service.dart';

class EditCategory extends StatefulWidget {
  const EditCategory({Key? key}) : super(key: key);

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  String name = "";
  String imageUrl = "";
  String error = "";
  bool loading = false;

  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments
        as Category; // is the category
    name = category.cName;
    imageUrl = category.imgUrl;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Category',
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
                    initialValue: category.cName,
                    keyboardType: TextInputType.name,
                    onChanged: (value) {
                      name = value.toString();
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      suffixIcon: Icon(Icons.shopping_bag_outlined),
                      hintText: 'Enter Category Name',
                      labelText: 'Name',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Category Name';
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
                    initialValue: category.imgUrl,
                    keyboardType: TextInputType.url,
                    onChanged: (value) {
                      imageUrl = value.toString();
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      suffixIcon: Icon(Icons.image),
                      hintText: 'Enter Product Image URL',
                      labelText: 'Image URL',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Product Image URL';
                      }
                      // else if (Uri.tryParse(value)!.hasAbsolutePath) {
                      //   return 'Please! Enter Product Image URL';
                      // }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    FloatingActionButton.extended(
                      label: const Text('Modify'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => loading = true);
                          var result =
                              await editCategory(category.cid, name, imageUrl);
                          // ignore: unnecessary_null_comparison
                          if (result == null) {
                            setState(() {
                              error = 'Could not Modify Category';
                              loading = false;
                            });
                          } else {
                            // ignore: avoid_print
                            print("Category Updated : " + result.cid);
                            Alert(
                              context: context,
                              type: AlertType.success,
                              title: "Success",
                              desc: "Category Modified Successfully",
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
