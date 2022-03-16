import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/providers/orders.dart';
import 'package:frontend/screens/authentication/myaccount.dart';
import 'package:frontend/screens/authentication/signup/signup.dart';
import 'package:frontend/screens/cart/cart.dart';
import 'package:frontend/screens/categories/categories.dart';
import 'package:frontend/screens/discussion/forum.dart';
import 'package:frontend/screens/merchant/merchant_home.dart';
import 'package:frontend/screens/orders/orderplaced.dart';
import 'package:frontend/screens/orders/orders_screen.dart';
import 'package:frontend/screens/product/product_detail_screen.dart';
import 'package:frontend/screens/product/products_overview.dart';
import 'package:provider/provider.dart';
import 'providers/cart.dart';
import 'providers/products.dart';
import 'providers/user_provider.dart';
import 'screens/authentication/signin/signin.dart';
import 'screens/home/home.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: UserProvider(),
        ),
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
          '/merchant-home': (context) => const MerchantHome(),
          '/signin': (context) => const SignIn(),
          '/signup': (context) => const SignUp(),
          '/myaccount': (context) => const MyAccount(),
          '/orderplaced': (context) => const OrderPlaced(),
          '/categories': (context) => const Categories(),
          '/cart': (context) => const CartScreen(),
          '/products-overview': (context) => const ProductsOverviewScreen(),
          '/orders': (context) => const OrdersScreen(),
          '/order-placed': (context) => const OrderPlaced(),
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
