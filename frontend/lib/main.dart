import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/screens/authentication/signup/signup.dart';
import 'package:frontend/screens/cart/cart.dart';
import 'package:frontend/screens/categories/categories.dart';
import 'package:frontend/screens/discussion/add_question.dart';
import 'package:frontend/screens/discussion/answers_screen.dart';
import 'package:frontend/screens/discussion/questions_screen.dart';
import 'package:frontend/screens/merchant/add_category.dart';
import 'package:frontend/screens/merchant/add_product.dart';
import 'package:frontend/screens/merchant/customer_specific_orders.dart';
import 'package:frontend/screens/merchant/customers_screen.dart';
import 'package:frontend/screens/merchant/edit_category.dart';
import 'package:frontend/screens/merchant/edit_product.dart';
import 'package:frontend/screens/merchant/merchant_categories.dart';
import 'package:frontend/screens/merchant/merchant_home.dart';
import 'package:frontend/screens/merchant/merchant_products_screen.dart';
import 'package:frontend/screens/orders/orderplaced.dart';
import 'package:frontend/screens/orders/orders_screen.dart';
import 'package:frontend/screens/product/product_detail_screen.dart';
import 'package:frontend/screens/product/products_overview.dart';
import 'package:frontend/screens/termsandconditions/termsconditions.dart';
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
        // ChangeNotifierProvider.value(
        //   value: Orders(),
        // ),
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
          '/terms-and-conditions': (context) => const TermsConditions(),
          '/orderplaced': (context) => const OrderPlaced(),
          '/categories': (context) => const Categories(),
          '/cart': (context) => const CartScreen(),
          '/products-overview': (context) => const ProductsOverviewScreen(),
          '/orders': (context) => const OrdersScreen(),
          '/order-placed': (context) => const OrderPlaced(),
          '/product-detail': (context) => const ProductDetailScreen(),
          '/merchant-categories': (context) => const MerchantCategories(),
          '/merchant-products': (context) => const MerchantProductsScreen(),
          '/customers-screen': (context) => const CustomersScreen(),
          '/add-category': (context) => const AddCategory(),
          '/add-product': (context) => const AddProduct(),
          '/edit-category': (context) => const EditCategory(),
          '/edit-product': (context) => const EditProduct(),
          '/customer-specific-orders': (context) =>
              const CustomerSpecificOrdersScreen(),
          '/questions': (context) => const QuestionsScreen(),
          '/answers': (context) => const AnswersScreen(),
          '/add-question': (context) => const AddQuestion()
        },
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: const SignIn(),
      ),
    );
  }
}
