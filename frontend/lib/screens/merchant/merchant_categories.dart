import 'package:flutter/material.dart';
import 'package:frontend/models/category.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../services/categories_service.dart';

class MerchantCategories extends StatefulWidget {
  const MerchantCategories({Key? key}) : super(key: key);

  @override
  State<MerchantCategories> createState() => _MerchantCategoriesState();
}

class _MerchantCategoriesState extends State<MerchantCategories> {
  late Future<List<Category>> futureCategories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // removing drawer from the screen
      // drawer: const MainDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed('/add-category').then((value) {
            setState(() {
              futureCategories = fetchCategories();
            });
          });
        },
        label: const Text('Add Category'),
        icon: const Icon(
          Icons.add_circle_outline,
          color: Colors.black,
        ),
      ),
      appBar: AppBar(
        title: const Text('Categories'),
        elevation: 5,
        // no actions buttons needed for merchant
        // actions: [
        //   // shopping cart
        //   IconButton(
        //       onPressed: () {
        //         setState(() {
        //           futureCategories = fetchCategories();
        //         });
        //       },
        //       icon: const Icon(Icons.refresh)),
        // ],
      ),
      body: SafeArea(
          child: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData == false) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          // using a grid view to display the categories
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: (snapshot.data as List<Category>).length,
              itemBuilder: (BuildContext context, int index) {
                // getting each category and sending it to the widget for building category item
                return buildCategoryItem(
                    (snapshot.data as List<Category>)[index]);
              });
        },
        future: futureCategories,
      )),
    );
  }

  Widget buildCategoryItem(Category category) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/merchant-products',
          arguments: {
            'id': category.cid,
            'title': category.cName,
          },
        );
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Card(
        elevation: 0,
        // using a stack for positioned widgets
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                child: Image.network(category.imgUrl,
                    fit: BoxFit.fill, width: 250, height: 250)),
            // position the text on the image
            Positioned(
              right: 0,
              bottom: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topLeft: Radius.circular(5)),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.black54,
                  width: 150,
                  child: Text(
                    category.cName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: TextButton(
                  child: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed('/edit-category', arguments: category)
                        .then((value) {
                      setState(() {
                        futureCategories = fetchCategories();
                      });
                    });
                  }),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: TextButton(
                  child: const Icon(Icons.delete_outline),
                  onPressed: () {
                    // delete the category
                    Alert(
                      context: context,
                      type: AlertType.warning,
                      title: "Delete Category",
                      desc: "Are you sure?",
                      buttons: [
                        DialogButton(
                          child: const Text(
                            "Yes",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () async {
                            Navigator.of(context).pop();
                            // Navigator.of(context).pop();
                            var result = await deleteCategory(category);
                            // ignore: unnecessary_null_comparison
                            if (result == null) {
                              // ignore: avoid_print
                              print("unable to delete category");
                            } else {
                              // ignore: avoid_print
                              print("Category deleted: PID is : " + result.cid);
                              setState(() {
                                futureCategories = fetchCategories();
                              });
                            }
                          },
                          width: 120,
                        ),
                        DialogButton(
                          child: const Text(
                            "No",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          width: 120,
                        )
                      ],
                    ).show();
                  }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    futureCategories =
        fetchCategories(); // fetch all the categories from backend
  }
}
