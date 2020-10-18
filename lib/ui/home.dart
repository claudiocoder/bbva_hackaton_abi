import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          // Define the default brightness and colors.
          primaryColor: Color(0xFF14549C),
          brightness: Brightness.dark),
      color: Color(0xFF14549C),
      home: Scaffold(
        appBar: AppBar(
          title: Text('ABI'),
        ),
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: EdgeInsets.only(top: 80),
      child: new Column(
        children: [
          Image.asset(
            'assets/images/sinpendientes.png',
            height: 200,
            fit: BoxFit.fill,
          ),
          _legend("Sin pendientes por autorizar")
        ],
      ),
    ));
  }
}

Widget _legend(String title) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: ListTile(
      title: Text(title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center),
    ),
  );
}
