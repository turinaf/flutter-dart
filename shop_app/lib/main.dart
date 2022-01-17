import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/splash_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './screens/cart_screen.dart';
import './providers/orders.dart';
import './providers/auth.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_products_screen.dart';
import './screens/auth_screen.dart';
import './helpers/custom_route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Product provider enables us to listen to the product anywere in the app
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          // create: (ctx, auth, previousProducts) => Products(),
          create: (_) => Products('', '', []),
          update: (ctx, auth, previousProducts) => Products(
              auth.token,
              auth.userID,
              previousProducts == null ? [] : previousProducts.items),
        ),
        ChangeNotifierProvider(
          create: (ctx) =>
              Cart(), // now we can listen to Cart anywhere in the app
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders("", '', []),
          update: (ctx, auth, previousOrder) => Orders(auth.token, auth.userID,
              previousOrder == null ? [] : previousOrder.orders),
        ),
      ],

      // -- Material rebuilds whenever auth changes i.e user logged in/out
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          theme: ThemeData(
              primarySwatch: Colors.purple,
              // accentColor: Colors.deepOrange,
              fontFamily: 'lato',
              pageTransitionsTheme: PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: CustomPageTransitionBuilder(),
                  TargetPlatform.iOS: CustomPageTransitionBuilder(),
                },
              )),
          home: auth.isAuth
              ? ProductsOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen()),
          debugShowCheckedModeBanner: false,
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UsersProductsScreen.routeName: (ctx) => UsersProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}

// class MyHomeScreen extends StatefulWidget {
//   const MyHomeScreen({Key? key}) : super(key: key);

//   @override
//   _MyHomeScreenState createState() => _MyHomeScreenState();
// }

// class _MyHomeScreenState extends State<MyHomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Shop app"),
//       ),
//       body: Center(
//         child: Text("Let's build shop app"),
//       ),
//     );
//   }
// }
