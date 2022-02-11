import 'package:flutter/material.dart';
import 'package:frontend/models/product.dart';

class productDetails extends StatelessWidget {
  const productDetails({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        leading: SizedBox(
          height: 40,
          width: 40,
          child: FlatButton(
            padding: EdgeInsets.zero,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            color: Colors.lightGreen,
            onPressed: () {},
            child: Icon(Icons.arrow_back_ios),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text("Product Details"),
            ),
          ],
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
              color: Colors.lightGreen,
            ),
            child: Icon(Icons.search),
          ),
          // IconButton(onPressed: (){},
          // icon: Icon(Icons.search))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    width: 240,
                    height: 300,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.asset(product.imgUrl),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    product.brandName,
                    style: TextStyle(fontSize: 20),
                  ),
                  margin: EdgeInsets.all(10),
                ),
                Container(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    "\$${product.price}",
                    style: TextStyle(fontSize: 20),
                  ),
                  margin: EdgeInsets.all(10),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    "Size",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    "Color",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    "Quantity",
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    "Buy now",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Product Details",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    product.details,
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    product.brandName,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    product.merchantName,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
