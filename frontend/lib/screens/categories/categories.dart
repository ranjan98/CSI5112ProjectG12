import 'package:flutter/material.dart';
import 'package:frontend/models/category.dart';
import '../home/maindrawer.dart';
import '../../../services/categories_service.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late Future<List<Category>> futureCategories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: const Text('Categories'),
        elevation: 5,
        actions: [
          // shopping cart
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/cart');
              },
              icon: const Icon(Icons.shopping_cart))
        ],
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
                maxCrossAxisExtent: 200,
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
          '/products-overview',
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
                child: Image.asset(category.imgUrl,
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
