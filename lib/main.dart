import 'file:///C:/Users/201706/Desktop/FlowerUI/lib/screens/store.widgets/store.main.menu.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Color.fromRGBO(130, 147, 153, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))
          )
        ),
        primaryColor: Colors.white,
        backgroundColor: Colors.white
      ),
      home: StoreMainMenu(),
    );
  }
}
