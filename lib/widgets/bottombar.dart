import 'package:flutter/material.dart';
import 'package:project_flutter/models/user_login.dart';

class BottomNav extends StatefulWidget {
  int activePage;
 BottomNav(this.activePage);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {  

  void getLink(index) {
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/add');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey[350],
      currentIndex: widget.activePage,
      onTap: (index) => {getLink(index)},
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home'
          ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Create')
      ],
     );
  }
}