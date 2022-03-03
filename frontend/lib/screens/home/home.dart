import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../models/category.dart';
import '../../shared/categories_data.dart';
import '../categories/categories.dart';
import 'maindrawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: const Text('Home'),
        elevation: 5,
        actions: [
          //search
          // IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          // shopping cart
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
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
              items: imageSliders,
            ),
            const SizedBox(
              height: 30,
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
              padding: const EdgeInsets.all(10),
              child: Wrap(
                children: [
                  // mock up list, will be replaced with dynamic data once connected with backend
                  buildCategoryItem(context, categoryData.elementAt(0)),
                  buildCategoryItem(context, categoryData.elementAt(1)),
                  buildCategoryItem(context, categoryData.elementAt(2)),
                  buildCategoryItem(context, categoryData.elementAt(3)),
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
                  // mock up products list, will be replaced with dynamic data once connected with backend
                  buildProductItem('assets/images/sample5.png', 'Puma Shoes',
                      '\$149', 'puma-shoes', context),
                  buildProductItem('assets/images/sample4.png',
                      'Apple Macbook Pro', '\$1299', 'macbook-pro', context),
                  buildProductItem('assets/images/sample7.jpg', 'iPhone 14',
                      '\$899', 'socks', context),
                  buildProductItem('assets/images/sample6.jpg', 'iPhone Cover',
                      '\$49', 'laptops', context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final List<String> imgList = [
  'https://images.unsplash.com/photo-1607082349566-187342175e2f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1483985988355-763728e1935b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1423666639041-f56000c27a9a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
];

final List<Widget> imageSliders = imgList
    .map(
      (item) => Container(
        margin: const EdgeInsets.all(5.0),
        child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Image.network(item, fit: BoxFit.cover, width: 1000.0),
              ],
            )),
      ),
    )
    .toList();

Widget buildCategoryItem(BuildContext context, Category category) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: InkWell(
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
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                child: Image.asset(category.imgUrl,
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
    ),
  );
}

Widget buildProductItem(String imgurl, String name, String price,
    String routeName, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: InkWell(
      onTap: () {
        Navigator.of(context).pushNamed("/" + routeName, arguments: name);
      },
      child: Card(
        elevation: 0,
        // using a stack for positioned widgets
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                child: Image.asset(imgurl,
                    fit: BoxFit.fill, width: 300, height: 300)),
            // position the text on the image
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                color: Colors.black54,
                width: 200,
                child: Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Text(
                price,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    backgroundColor: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
