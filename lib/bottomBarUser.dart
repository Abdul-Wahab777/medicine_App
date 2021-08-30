import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'UserScreens/User.dart';
import 'UserScreens/UserChat.dart';
import 'data/Profile.dart';
import 'medcineform.dart';

class AliMola extends StatefulWidget {
  @override
  _AliMolaState createState() => _AliMolaState();
}

class _AliMolaState extends State<AliMola> {
  int _currentIndex = 0;

  Widget buildpage() {
    switch (_currentIndex) {
      case 0:
        return UserScreen();
      case 1:
        return UserChatMessage();
      case 2:
        return MedicineDetail();
      case 3:
        return Profile();
      default:
        return UserScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildpage(),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) => setState(() => _currentIndex = index),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text('Home'),
            activeColor: Color(0xFF1A237E),
            textAlign: TextAlign.center,
          ),
         BottomNavyBarItem(
            icon: Icon(Icons.chat),

            title: Text('Chat'),
            activeColor: Color(0xFF1A237E),
            textAlign: TextAlign.center,
          ),
         BottomNavyBarItem(
            icon: Icon(Icons.add),
            title: Text(
              'Donate',
            ),
            activeColor: Color(0xFF1A237E),
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text('profile'),
            activeColor: Color(0xFF1A237E),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}