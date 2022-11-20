import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/global.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/views/category_meals_page.dart';
import 'package:meals_app/views/filters_page.dart';
import 'package:meals_app/views/meal_detail_page.dart';
import 'package:meals_app/views/tabs_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = dummyMeals;
final List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = dummyMeals.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(
          dummyMeals.firstWhere((meal) => meal.id == mealId),
        );
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        // colorScheme: ColorScheme.fromSwatch(primarySwatch : Colors.pink),
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyText1: const TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1)
          ),
          bodyText2: const TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1)
          ),
          headline6: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoCondensed',
          )
        ),
      ),
      // home: const CategoriesPage(),
      initialRoute: '/',
       routes: {
        '/': (ctx) => TabsPage(_favoriteMeals),
        // '/' : (ctx) => const CategoriesPage(),
        RouteNames.categoryMealsPageRoute : (ctx) => CategoryMealsPage(_availableMeals),
        RouteNames.mealDetailPageRoute: (ctx) => MealDetailPage(_toggleFavorite, _isMealFavorite),
        RouteNames.filtersPageRoute:(ctx) => FiltersPage(_filters, _setFilters),
      },
    );
  }
}
