import 'package:flutter/material.dart';
import './products_grid.dart';

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    final categoryArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryArguments['title'].toString()),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/cart');
              },
              icon: const Icon(Icons.shopping_cart))
        ],
      ),
      // Not using drawer as of now on the products page
      // drawer: const MainDrawer(),
      body: ProductsGrid(id: categoryArguments['id'].toString()),
    );
  }
}
