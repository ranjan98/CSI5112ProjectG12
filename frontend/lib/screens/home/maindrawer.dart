import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  // function to render out the items in the drawer
  // provides code reusability this way
  Widget buildDrawerItem(
      String title, IconData icon, Color color, drawerTapHandler) {
    return ListTile(
      title: Text(title),
      trailing: Icon(icon, color: color),
      onTap: drawerTapHandler,
    );
  }

  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          // show the basic details for the user via the header
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.orange),
            accountName: Text('Ranjan Goyal'),
            accountEmail: Text('rgoya021@uottawa.ca'),
            currentAccountPicture: CircleAvatar(
              // We can either put an image here or text like initials of user
              //backgroundImage: NetworkImage(''),
              backgroundColor: Colors.purple,
              child: Text(
                'RG',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          // add drawer item
          buildDrawerItem('Home', Icons.person, Colors.cyan, () {
            Navigator.of(context).pop();
            Navigator.of(context).popAndPushNamed('/home');
          }),
          // adding a divider line to separate items in the drawer
          const Divider(),
          buildDrawerItem('Orders', Icons.local_shipping, Colors.cyan, () {
            Navigator.of(context).popAndPushNamed('/orders');
          }),
          const Divider(),
          buildDrawerItem('Categories', Icons.category_outlined, Colors.green,
              () {
            // Navigator.of(context).pop();
            Navigator.of(context).popAndPushNamed('/categories');
          }),
          // We will show categories first and then products for that category
          // const Divider(),
          // buildDrawerItem('Products', Icons.category_outlined, Colors.green,
          //     () {
          //   Navigator.of(context).pop();
          //   Navigator.of(context).pushNamed('/products-overview');
          // }),
          const Divider(),
          buildDrawerItem('Cart', Icons.shopping_cart, Colors.deepPurple, () {
            // Navigator.of(context).pop();
            Navigator.of(context).popAndPushNamed('/cart');
          }),
          const Divider(),
          buildDrawerItem('Sign Out', Icons.person_outline, Colors.deepPurple,
              () {
            Navigator.popUntil(context, ModalRoute.withName('/signin'));
            Navigator.of(context).pushNamed('/signin');
          }),
          const Divider(),
          // just pops up the drawer
          buildDrawerItem('Close', Icons.close, Colors.red, () {
            Navigator.of(context).pop();
          }),
        ],
      ),
    );
  }
}
