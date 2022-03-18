import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:frontend/models/category.dart';
import 'package:frontend/services/categories_service.dart';
import '../../providers/user_provider.dart';
import '../../services/products_service.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  late Future<List<Category>> futureCategories;
  String name = "";
  String category = "";
  String description = "";
  String price = "";
  String merchantid = "3";
  String imageUrl = "";
  String error = "";
  bool loading = false;

  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    try {
      merchantid = userProvider.users.first.uid;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Product',
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
                  child: FutureBuilder(
                    future: futureCategories,
                    builder: (context, snapshot) {
                      if (snapshot.hasData == false) {
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      List<Category> categories =
                          snapshot.data as List<Category>;
                      return DropdownButtonFormField(
                        items: categories.map((Category value) {
                          return DropdownMenuItem<Category>(
                            value: value,
                            child: Text(value.cName),
                          );
                        }).toList(),
                        onChanged: (value) {
                          category = (value as Category).cid;
                          // print(category);
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            suffixIcon: Icon(Icons.category),
                            hintText: 'Choose Product Category'),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 6),
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
                      hintText: 'Enter Product Name',
                      labelText: 'Name',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Product Name';
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
                    keyboardType: TextInputType.name,
                    onChanged: (value) {
                      description = value.toString();
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      suffixIcon: Icon(Icons.description),
                      hintText: 'Enter Product Description',
                      labelText: 'Description',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Product Description';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: 320,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      price = num.parse(value).toStringAsFixed(2);
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                      suffixIcon: Icon(Icons.attach_money),
                      hintText: 'Enter Product Price',
                      labelText: 'Price',
                    ),
                    validator: (value) {
                      if (value!.isEmpty || double.tryParse(value) == null) {
                        return 'Please Enter Product Price';
                      }
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
                      label: const Text('Add Product'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (category == "") {
                            setState(() {
                              error = "Choose Product Category";
                            });
                          } else {
                            setState(() => loading = true);
                            var result = await addProduct(name, merchantid,
                                category, description, price, imageUrl);
                            // ignore: unnecessary_null_comparison
                            if (result == null) {
                              setState(() {
                                error = 'Could not Add Product';
                                loading = false;
                              });
                            } else {
                              // ignore: avoid_print
                              print("Product Added: PID is : " + result.id);
                              Alert(
                                context: context,
                                type: AlertType.success,
                                title: "Added",
                                desc: "Product Added Successfully",
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

  @override
  void initState() {
    super.initState();
    futureCategories = fetchCategories();
  }
}
