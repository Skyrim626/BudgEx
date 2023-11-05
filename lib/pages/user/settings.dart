import 'package:flutter/material.dart';
import 'package:budgex/pages/user/settings-main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsWhole();
}

class _SettingsWhole extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              width: 500,
              height: 280,
              color: Colors.cyan.shade800,
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        height: 200,
                        width: 400,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 2)),
                        child: Icon(Icons.person, size: 170),
                      ),
                      Positioned(
                        top: 140,
                        left: 2,
                        right: 1,
                        child: Container(
                          height: 70,
                          width: 400,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(color: Colors.black)),
                          child: IconButton(
                            icon: const Icon(Icons.camera_alt, size: 40),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'John Doe',
                    style: TextStyle(fontSize: 32, color: Colors.white),
                  ),
                ],
              ),
            ),
            SettingsMain(),
          ],
        ),
      ),
    );

    // const Center(
    //   child: Text(
    //     'This is settings page',
    //     style: TextStyle(fontSize: 24),
    //   ),
    // ),
  }
}
