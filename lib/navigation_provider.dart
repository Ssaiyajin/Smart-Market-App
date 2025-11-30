import 'package:flutter/material.dart';
import 'package:smarket_app/screens/bookmarks_page.dart';

import 'screens/home_page.dart';

/// Provides the navigation between the app pages through a BottomNavigationBar.
class NavigationProvider extends StatefulWidget {
  final String? title;

  const NavigationProvider({Key? key, this.title}) : super(key: key);

  @override
  NavigationProviderState createState() => NavigationProviderState();
}

class NavigationProviderState extends State<NavigationProvider>
    with TickerProviderStateMixin {
  int _selectedPageIndex = 0; // start with HomePage

  // available pages to display in tabs
  final List<Widget> _pages = <Widget>[
    const HomePage(),
    const BookmarksPage(),
    // TODO: add screens (order is important)
  ];

  // the respective tab bar items / icons, for each page
  final List<BottomNavigationBarItem> _navBarItems = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.bookmark),
      label: 'Bookmarks',
    ),
  ];

  void _onItemTapped(int newIndex) {
    setState(() {
      _selectedPageIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedPageIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _navBarItems,
        currentIndex: _selectedPageIndex,
        onTap: _onItemTapped,
        selectedItemColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
