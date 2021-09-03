import 'package:flutter/material.dart';

import './category_meals_screen.dart';
import './categories_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String categoryRoute = '/category-meals';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
              ),
            ),
      ),
      debugShowCheckedModeBanner: false,
      // home: CategoriesScreen(),
      routes: {
        '/': (ctx) => CategoriesScreen(), // defualt one for homescreen
        categoryRoute: (ctx) => CategoryMealsScreen(),
      },
    );
  }
}
