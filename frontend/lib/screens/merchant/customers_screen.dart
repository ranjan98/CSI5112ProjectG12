import 'package:flutter/material.dart';
import 'package:frontend/screens/merchant/customer_specific_orders.dart';

import '../../models/user.dart';
import '../../services/signin_service.dart';
// import '../../providers/orders.dart' show Orders;

class CustomersScreen extends StatefulWidget {
  static const routeName = '/customers-screen';

  const CustomersScreen({Key? key}) : super(key: key);

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  late Future<List<User>> futureUsers;

  // removed the static data for orders and fetching from backend
  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Customer'),
      ),
      // drawer: const MainDrawer(),
      body: FutureBuilder(
        future: futureUsers,
        builder: (context, snapshot) {
          if (snapshot.hasData == false) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          try {
            (snapshot.data as List<User>)
                .removeWhere((element) => element.role != "customer");
          } catch (e) {
            // ignore: avoid_print
            print(e.toString());
          }
          return ListView.builder(
              itemCount: (snapshot.data as List<User>).length,
              itemBuilder: (BuildContext context, int index) {
                // getting each order and sending it to the widget for building order item
                return buildUserItem((snapshot.data as List<User>)[index]);
              });
        },
      ),
    );
  }

  Widget buildUserItem(User user) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(CustomerSpecificOrdersScreen.routeName, arguments: user);
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(user.name),
              subtitle: Text(user.email),
              // removing trailing icon and using InkWell instead
              // trailing: IconButton(
              //   icon: const Icon(Icons.arrow_right_alt),
              //   onPressed: () {
              //     Navigator.of(context).pushNamed(
              //         CustomerSpecificOrdersScreen.routeName,
              //         arguments: user);
              //   },
              // ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    futureUsers = fetchUsers(); // fetch the orders
  }
}
