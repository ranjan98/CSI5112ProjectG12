import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
            const Text(
              'Categories',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5),
              child: Wrap(
                children: [
                  // mock up products list, will be replaced with dynamic data once connected with backend
                  buildProductItem('assets/images/sample1.jpg', 'T-Shirts',
                      'tshirts', context),
                  buildProductItem(
                      'assets/images/sample2.jpg', 'Shoes', 'shoes', context),
                  buildProductItem(
                      'assets/images/sample3.png', 'Socks', 'socks', context),
                  buildProductItem('assets/images/sample4.png', 'Laptops',
                      'laptops', context),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Recommended',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
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

Widget buildProductItem(
    String imgurl, String name, String routeName, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: InkWell(
      onTap: () {
        Navigator.of(context).pushNamed("/" + routeName, arguments: name);
      },
      child: Card(
        elevation: 0,
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                child: Image.asset(imgurl,
                    fit: BoxFit.fill, width: 180, height: 150)),
            Positioned(
              right: 0,
              bottom: 0,
              child: Text(
                name,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    backgroundColor: Colors.white54),
              ),
            ),
            // Text(
            //   name,
            //   style: const TextStyle(fontSize: 20),
            // ),
          ],
        ),
      ),
    ),
  );
}
