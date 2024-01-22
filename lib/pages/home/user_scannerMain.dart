import 'package:flutter/material.dart';
import 'package:budgex/pages/home/user_scannerOCR.dart';
import 'package:budgex/pages/home/user_scannerQR.dart';

class MainScanner extends StatelessWidget {
  const MainScanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Receipt Scanner Options"),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => UserScanReceipt())
                );
              },
              child: const Card(
                child: Text("Scan\nQR"),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => OCRScreen())
                );
              },
              child: const Card(
                child: Text("Scan\nOCR"),
              ),
            ),
          ],
        ),
      ),
    );
  }

}