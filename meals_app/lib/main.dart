import 'package:flutter/material.dart';
import 'package:meals_app/screens/meal_detail_screen.dart';

import './screens/category_meals_screen.dart';
import './screens/categories_screen.dart';

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
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(),
      },
      // Used when the route is not defined in routes.
      // onGenerateRoute is your fallback/ option to have more control about the creation + configuration of routing actions (= MaterialPageRoute that then loads a specific screen widget).
      // onGenerateRoute: (settings) {
      //   print(settings.arguments);
      //   return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      // },

      // UnknownRoute is reached when flutter failed to build screen with all other measures/defined routes.
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
