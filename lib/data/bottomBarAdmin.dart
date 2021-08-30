import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/data/fila.dart';

import '../UserScreens/User.dart';
import '../chatSc/chat_body.dart';
import 'Admin Dashboard.dart';
import 'Profile.dart';
import '../medcineform.dart';
import 'Setting.dart';
class BottomBarAdmin extends StatefulWidget {
  @override
  _BottomBarAdminState createState() => _BottomBarAdminState();
}

class _BottomBarAdminState extends State<BottomBarAdmin> {
  int _currentIndex = 0;

  Widget buildpage() {
    switch (_currentIndex) {
      case 0:
        return Irfan();
      case 1:
        return CharBody();
      case 2:
        return Chart();
      case 3:
        return Profile();
      case 4:
        return Setting();
      default:
        return UserScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildpage(),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: 0,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) => setState(() => _currentIndex = index),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text('Home'),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.chat),

            title: Text('Chat'),
            activeColor: Colors.purpleAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.add),
            title: Text(
              'Donate',
            ),
            activeColor: Colors.pink,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text('profile'),
            activeColor: Colors.blue,
            textAlign: TextAlign.center,
          ),

           BottomNavyBarItem(
            icon: Icon(Icons.settings),
            title: Text('Setting'),
            activeColor: Colors.grey,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
