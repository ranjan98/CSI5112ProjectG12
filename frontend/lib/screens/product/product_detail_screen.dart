import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../../providers/cart.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/product-detail';

  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late Future<Product> futureProduct;
  @override
  Widget build(BuildContext context) {
    final loadedProduct =
        ModalRoute.of(context)!.settings.arguments as Product; // is the id
    // replaced with backend
    // final loadedProduct = Provider.of<Products>(
    //   context,
    //   listen: false,
    // ).findById(productId);
    final cart = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.name),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/cart');
              },
              icon: const Icon(Icons.shopping_cart))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 500,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '\$${loadedProduct.price}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                loadedProduct.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/forum');
              },
              child: const Text('Go to Discussion'),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  cart.addItem(loadedProduct.id.toString(),
                      double.parse(loadedProduct.price), loadedProduct.name);
                  final snackBar = SnackBar(
                    content: const Text(
                      'Added item to cart!',
                    ),
                    duration: const Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        cart.removeSingleItem(loadedProduct.id.toString());
                      },
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: const [
                    Text(
                      " Add to Cart",
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    Icon(Icons.add_shopping_cart)
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
