import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:frontend/services/categories_service.dart';
import 'package:frontend/services/products_service.dart';
import 'package:provider/provider.dart';
import '../../models/category.dart';
import '../../models/product.dart';
import '../../providers/cart.dart';
import 'maindrawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Product>> futureProducts;
  late Future<List<Category>> futureCategories;

  @override
  Widget build(BuildContext context) {
    // setting up aspect ratio for different screen sizes
    double aspectRatio = 5 / 2;
    if (MediaQuery.of(context).size.width > 1000) {
      aspectRatio = 7 / 2;
    }
    final List<Widget> imageSliders = sliderList
        .map(
          (item) => Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          '/products-overview',
                          arguments: {
                            'id': item[0].toString(),
                            'title': item[1].toString(),
                          },
                        );
                      },
                      child: Image.network(item[2],
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width),
                    )
                  ],
                )),
          ),
        )
        .toList();

    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: const Text('Home'),
        elevation: 5,
        actions: [
          // adding cart button
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/cart');
              },
              icon: const Icon(Icons.shopping_cart))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // promotional images in the carousel

            AspectRatio(
              aspectRatio: aspectRatio,
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                ),
                items: imageSliders,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/categories');
                      },
                      child: const Text('View All'))
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5),
              child: Wrap(
                children: [
                  // getting random categories from backend for home page
                  for (int i = 0; i < 4; i++) buildCatItem(context, i)
                ],
              ),
            ),

            const SizedBox(
              height: 30,
            ),
            const Text(
              'Top Products',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5),
              child: Wrap(
                children: [
                  // getting random products from backend for home page
                  for (int i = 0; i < 4; i++) buildProductItem(context, i)
                ],
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
    futureProducts = fetchProducts(); // fetch all the products from backend
    futureCategories = fetchCategories(); // fetch all categories from backend
  }

  Widget buildCatItem(BuildContext context, var index) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: FutureBuilder(
          future: futureCategories,
          builder: (context, snapshot) {
            if (snapshot.hasData == false) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            var category = (snapshot.data as List<Category>).elementAt(index);
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
              child: Card(
                elevation: 0,
                // using a stack for positioned widgets
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5)),
                        child: Image.network(category.imgUrl,
                            fit: BoxFit.fill, width: 200, height: 150)),
                    // position the text on the image
                    Positioned(
                      right: 0,
                      bottom: 0,
                      width: 200,
                      child: Text(
                        category.cName,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            backgroundColor: Colors.black54),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget buildProductItem(BuildContext context, var index) {
    // replacing the mock data with backend data
    // final productsData = Provider.of<Products>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    // final products = productsData.items;
    // products.removeWhere((element) => element.category != id);
    // get only 1 product for now
    // final product = products.firstWhere((element) => element.id == id);
    return FutureBuilder(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.hasData == false) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          var product = (snapshot.data as List<Product>).elementAt(index);
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  '/product-detail',
                  arguments: product,
                );
              },
              child: Card(
                elevation: 0,
                // using a stack for positioned widgets
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5)),
                        child: Image.network(product.imageUrl,
                            fit: BoxFit.fill, width: 200, height: 150)),
                    // position the text on the image
                    Positioned(
                      right: 0,
                      top: 0,
                      child: TextButton(
                          child: const Icon(Icons.add_shopping_cart),
                          onPressed: () {
                            cart.addItem(product.id.toString(),
                                double.parse(product.price), product.name);
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
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      width: 150,
                      child: Text(
                        product.name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            backgroundColor: Colors.black54),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Text(
                        "\$" + double.parse(product.price).toStringAsFixed(0),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            backgroundColor: Colors.black54),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

// final List<String> imgList = [
//   'https://images.unsplash.com/photo-1607082349566-187342175e2f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1950&q=80',
//   'https://images.unsplash.com/photo-1483985988355-763728e1935b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1950&q=80',
//   'https://images.unsplash.com/photo-1423666639041-f56000c27a9a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1950&q=80',
//   'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
// ];

final List sliderList = [
  [
    5,
    "Sale",
    'https://images.unsplash.com/photo-1607082349566-187342175e2f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1950&q=80'
  ],
  [
    1,
    "Fashion",
    'https://images.unsplash.com/photo-1483985988355-763728e1935b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1950&q=80'
  ],
  [
    2,
    "Laptop and Mobiles",
    'https://images.unsplash.com/photo-1423666639041-f56000c27a9a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1950&q=80'
  ],
  [
    4,
    "Accessories",
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80'
  ]
];
