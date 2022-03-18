import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/models/order.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/services/orders_service.dart';
import 'package:provider/provider.dart';
// import '../../providers/orders.dart' show Orders;

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late Future<List<Order>> futureOrders;
  var _expanded = false;

  // removed the static data for orders and fetching from backend
  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<Orders>(context);
    final userProvider = Provider.of<UserProvider>(context);
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
            if (userProvider.users.first.role == "customer") {
              (snapshot.data as List<Order>).removeWhere(
                  (element) => element.userId != userProvider.users.first.uid);
            }
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
            subtitle: Text(order.datetime.toString()
                // DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
                ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
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
