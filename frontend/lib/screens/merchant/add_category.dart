import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../services/categories_service.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  String name = "";
  String imageUrl = "";
  String error = "";
  bool loading = false;

  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Category',
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
                      label: const Text('Add Category'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() => loading = true);
                          var result = await addCategory(name, imageUrl);
                          // ignore: unnecessary_null_comparison
                          if (result == null) {
                            setState(() {
                              error = 'Could not Add Category';
                              loading = false;
                            });
                          } else {
                            // ignore: avoid_print
                            print("Product Added: CID is : " + result.cid);
                            Alert(
                              context: context,
                              type: AlertType.success,
                              title: "Added",
                              desc: "Category Added Successfully",
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
