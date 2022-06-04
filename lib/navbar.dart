import 'package:flutter/material.dart';
import 'package:project_tpm/view/category_blush.dart';
import 'package:project_tpm/view/category_eyeshadow.dart';
import 'package:project_tpm/view/home.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    Home(),
    CategoryBlush(),
    CategoryEye()
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex),),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            title: Text("HOME"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.face_outlined),
            title: Text("BLUSH"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.visibility_outlined),
            title: Text("EYESHADOW"),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
