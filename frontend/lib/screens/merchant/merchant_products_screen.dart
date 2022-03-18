import 'package:flutter/material.dart';

import 'merchant_products_grid.dart';

class MerchantProductsScreen extends StatefulWidget {
  const MerchantProductsScreen({Key? key}) : super(key: key);

  @override
  _MerchantProductsScreenState createState() => _MerchantProductsScreenState();
}

class _MerchantProductsScreenState extends State<MerchantProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final categoryArguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed('/add-product');
        },
        label: const Text('Add Product'),
        icon: const Icon(
          Icons.add_circle_outline,
          color: Colors.black,
        ),
      ),
      appBar: AppBar(
        title: Text(categoryArguments['title'].toString()),
      ),
      // Not using drawer as of now on the products page
      // drawer: const MainDrawer(),
      body: MerchantProductsGrid(id: categoryArguments['id'].toString()),
    );
  }
}
