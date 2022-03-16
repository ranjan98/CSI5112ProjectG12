import 'package:flutter/material.dart';
// import 'package:frontend/models/cart.dart';
// import 'package:frontend/models/cart.dart';
import 'package:frontend/services/orders_service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
// import '../../models/cart.dart';
import '../../providers/cart.dart' show Cart, CartItem;
import '../../providers/user_provider.dart';
import 'cart_item.dart';
// import '../../providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                    child: const Text('Order Now'),
                    onPressed: () async {
                      if (cart.totalAmount > 0) {
                        var order = cart.items.values.cast<CartItem>().toList();

                        var total = cart.totalAmount;
                        var invoiceNumber =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        var datetime = DateFormat("yyyy-MM-dd hh:mm:ss")
                            .format(DateTime.now());
                        var result = await createOrder(
                            invoiceNumber,
                            userProvider.users.first.uid,
                            total,
                            order,
                            datetime.toString());
                        // ignore: avoid_print
                        print(result.invoiceNumber);
                        // Provider.of<Orders>(context, listen: false).addOrder(
                        //   cart.items.values.toList(),
                        //   cart.totalAmount,
                        // );
                        cart.clear();

                        Navigator.of(context).popAndPushNamed('/order-placed',
                            arguments: [order, total]);
                      }
                    },
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) => CartItemComponent(
                cart.items.values.toList()[i].id,
                cart.items.keys.toList()[i],
                cart.items.values.toList()[i].price,
                cart.items.values.toList()[i].quantity,
                cart.items.values.toList()[i].title,
              ),
            ),
          )
        ],
      ),
    );
  }
}
