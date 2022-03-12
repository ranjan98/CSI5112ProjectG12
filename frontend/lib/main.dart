import 'package:flutter/material.dart';
import 'package:frontend/providers/orders.dart';
import 'package:frontend/screens/authentication/forgotpassword/emailsend.dart';
import 'package:frontend/screens/authentication/forgotpassword/forgotpassword.dart';
import 'package:frontend/screens/authentication/myaccount.dart';
import 'package:frontend/screens/authentication/signup/signup.dart';
import 'package:frontend/screens/cart/cart.dart';
import 'package:frontend/screens/categories/categories.dart';
import 'package:frontend/screens/discussion/forum.dart';
import 'package:frontend/screens/orders/orderplaced.dart';
import 'package:frontend/screens/orders/orders_screen.dart';
import 'package:frontend/screens/product/product_detail_screen.dart';
import 'package:frontend/screens/product/products_overview.dart';
import 'package:provider/provider.dart';
import 'providers/cart.dart';
import 'providers/products.dart';
import 'screens/authentication/signin/signin.dart';
import 'screens/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        initialRoute: '/',
        routes: {
          '/home': (context) => const Home(),
          '/signin': (context) => const SignIn(),
          '/signup': (context) => const SignUp(),
          '/myaccount': (context) => const MyAccount(),
          '/forgotpassword': (context) => const ForgotPassword(),
          '/emailsent': (context) => const EmailSent(),
          '/orderplaced': (context) => const OrderPlaced(),
          '/categories': (context) => const Categories(),
          '/cart': (context) => const CartScreen(),
          '/products-overview': (context) => const ProductsOverviewScreen(),
          '/orders': (context) => const OrdersScreen(),
          '/forum': (context) => const Forum(),
          '/product-detail': (context) => const ProductDetailScreen()
        },
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: const SignIn(),
      ),
    );
  }
}
