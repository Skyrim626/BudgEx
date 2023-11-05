import 'package:flutter/material.dart';
/* import 'package:mobprob_act/settings-popup.dart'; */

class SettingsMain extends StatefulWidget {
  const SettingsMain({super.key});

  @override
  State<SettingsMain> createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsMain> {
  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          Container(
            width: 400,
            height: 423,
            color: Colors.cyan.shade800,
          ),
          Positioned(
            left: 30,
            child: Container(
              width: 335,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    height: 40,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            'USERNAME',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          'John Doe',
                          style: TextStyle(
                              color: Colors.grey, fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 10, right: 50),
                          child: Text(
                            'EMAIL',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          'jo****e3@gmail.com',
                          style: TextStyle(
                              color: Colors.grey, fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.cyan.shade800)),
                      child: Text('EDIT'),
                      onPressed: () {
                        openInfoDialog();
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    height: 50,
                    child: Row(
                      children: <Widget>[
                        Text(
                          'PASSWORD',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Container(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.cyan.shade800),
                            ),
                            child: Text('EDIT'),
                            onPressed: () {
                              openPassDialog();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    height: 50,
                    child: Row(
                      children: <Widget>[
                        Text(
                          'THEME',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Container(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.cyan.shade800),
                            ),
                            child: Text('EDIT'),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    height: 50,
                    child: Row(
                      children: <Widget>[
                        Text(
                          'NOTIFICATIONS',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Container(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.cyan.shade800),
                            ),
                            child: Text('EDIT'),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                      ),
                      child: Text('LOG OUT'),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  Future openInfoDialog() => showDialog(
        context: context,
        builder: (context) => Center(
          child: Container(
            height: 450,
            width: 500,
            child: AlertDialog(
              title: Text('Update your information'),
              content: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'CHANGE USERNAME',
                      ),
                      Spacer(),
                    ],
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: 'John Doe'),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          'CHANGE EMAIL',
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  TextField(
                    decoration: InputDecoration(hintText: 'jo****e3@gmail.com'),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          'OBTAIN VERIFICATION CODE',
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  TextField(
                    decoration:
                        InputDecoration(hintText: 'Enter verification code'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {},
                  child: Text('SUBMIT'),
                ),
              ],
            ),
          ),
        ),
      );

  Future openPassDialog() => showDialog(
        context: context,
        builder: (context) => Center(
          child: Container(
            height: 450,
            width: 500,
            child: AlertDialog(
              title: Text('Update your password'),
              content: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'CURRENT PASSWORD',
                      ),
                      Spacer(),
                    ],
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintText: 'Enter your current password'),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          'NEW PASSWORD',
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  TextField(
                    decoration:
                        InputDecoration(hintText: 'Enter your new password'),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          'CONFIRM NEW PASSWORD',
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  TextField(
                    decoration:
                        InputDecoration(hintText: 'Re-enter your new password'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {},
                  child: Text('CANCEL'),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('SUBMIT'),
                ),
              ],
            ),
          ),
        ),
      );
}
