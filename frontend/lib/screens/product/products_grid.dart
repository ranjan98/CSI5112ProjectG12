import 'package:flutter/material.dart';
import 'package:frontend/screens/product/product_detail_screen.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../providers/cart.dart';
import '../../services/products_service.dart';

class ProductsGrid extends StatefulWidget {
  final String id;
  const ProductsGrid({Key? key, required this.id}) : super(key: key);

  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  late Future<List<Product>> futureProducts;
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context, listen: false);
    // final productsData = Provider.of<Products>(context);
    // final products = productsData.items;
    // products.removeWhere((element) => element.category != widget.id);
    return SafeArea(
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
            padding: const EdgeInsets.all(10.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: (snapshot.data as List<Product>).length,
            itemBuilder: (BuildContext context, int index) {
              // getting each category and sending it to the widget for building category item
              return buildProductItem(
                  (snapshot.data as List<Product>)[index], cart);
            });
      },
      future: futureProducts,
    ));
  }

  Widget buildProductItem(Product product, Cart cart) {
    // final product = Provider.of<Product>(context, listen: false); // replaced with new data model which is using backend
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
            product.name,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.add_shopping_cart_outlined,
            ),
            onPressed: () {
              cart.addItem(product.id.toString(), double.parse(product.price),
                  product.name);
              final snackBar = SnackBar(
                content: const Text(
                  'Added item to cart!',
                ),
                duration: const Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    cart.removeSingleItem(product.id.toString());
                  },
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    futureProducts = fetchProductsForOneCategory(
        widget.id); // fetch all the products from backend
  }
}
