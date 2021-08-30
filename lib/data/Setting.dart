import 'package:flutter/material.dart';

import 'MakeAdmin.dart';


class Setting extends StatefulWidget {

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
          title: Text("Setting"),),
        body: Container(
          margin: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Card(
                child: ListTile(
                  tileColor: Colors.yellow[100],
                  leading: Icon(Icons.admin_panel_settings),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> MakeAdmin()));
                  },
                  title: Text("Admin & User Setting"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}