import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final Function onTap;
  final int index;

  final List<Item> _items = [
    Item(name: "Home", icon: Icons.home),
    Item(name: "My Docs", icon: Icons.history),
  ];

  BottomNavBar({this.onTap, this.index = 0});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: onTap,
        currentIndex: index,
        elevation: 22.0,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        items: _items
            .map((Item item) => BottomNavigationBarItem(
                icon: Icon(item.icon), title: Text("${item.name}")))
            .toList());
  }
}

class Item {
  String name;
  IconData icon;

  Item({this.name, this.icon});
}
