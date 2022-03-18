import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/models/order.dart';
import 'package:frontend/services/orders_service.dart';

import '../../models/user.dart';
// import '../../providers/orders.dart' show Orders;

class CustomerSpecificOrdersScreen extends StatefulWidget {
  static const routeName = '/customer-specific-orders';

  const CustomerSpecificOrdersScreen({Key? key}) : super(key: key);

  @override
  State<CustomerSpecificOrdersScreen> createState() =>
      _CustomerSpecificOrdersScreenState();
}

class _CustomerSpecificOrdersScreenState
    extends State<CustomerSpecificOrdersScreen> {
  late Future<List<Order>> futureOrders;

  // removed the static data for orders and fetching from backend
  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);
    // final userProvider = Provider.of<UserProvider>(context);
    final loadedUser =
        ModalRoute.of(context)!.settings.arguments as User; // is the id
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      // drawer: const MainDrawer(),
      body: FutureBuilder(
        future: futureOrders,
        builder: (context, snapshot) {
          if (snapshot.hasData == false) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          try {
            (snapshot.data as List<Order>)
                .removeWhere((element) => element.userId != loadedUser.uid);
          } catch (e) {
            // ignore: avoid_print
            print(e.toString());
          }
          return ListView.builder(
              itemCount: (snapshot.data as List<Order>).length,
              itemBuilder: (BuildContext context, int index) {
                // getting each order and sending it to the widget for building order item
                return buildOrderItem((snapshot.data as List<Order>)[index]);
              });
        },
      ),
    );
  }

  Widget buildOrderItem(Order order) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${order.amount.toStringAsFixed(2)}'),
            subtitle: Text(order.datetime.toString()),
          ),
          const Text(
            "Items",
            style: TextStyle(fontSize: 20),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            height: min(order.items.length * 20.0 + 10, 100),
            child: ListView(
              children: order.items
                  .map(
                    (prod) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          prod.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${prod.quantity}x \$${prod.price}',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    futureOrders = fetchOrders(); // fetch the orders
  }
}
