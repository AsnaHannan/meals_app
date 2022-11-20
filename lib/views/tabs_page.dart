import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/views/categories_page.dart';
import 'package:meals_app/views/favorites_page.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsPage extends StatefulWidget {
  
  final List<Meal> favoriteMeals;
  TabsPage(this.favoriteMeals);

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  late List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

@override
  void initState() {
    _pages = [
    {
      'page': const CategoriesPage(),
      'title': 'Categories',
    },
    {
      'page': FavoritesPage(widget.favoriteMeals),
      'title': 'Your Favorite',
    },
  ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text(_pages[_selectedPageIndex]['title'] as String),
      ),
      drawer: const MainDrawer(),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.black,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: const Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: const Icon(Icons.star),
           label: 'Favorites',
          ),
        ],
      ),
    );
  }
}