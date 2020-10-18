import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatusPage extends StatefulWidget {
  StatusPage({Key key}) : super(key: key);

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  bool status = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromRGBO(6, 35, 72, 1),
          body: ListView(
              padding: EdgeInsets.symmetric(vertical: 90),
              children: [_layout()])),
    );
  }

  Widget _layout() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 550,
        decoration: new BoxDecoration(color: Colors.white),
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _sourceAndDesination(
                    'Status', status ? 'Completada con exito' : 'Algo fallo'),
                Icon(
                  status ? Icons.done_outline : Icons.location_off,
                  color: status ? Colors.green : Colors.red,
                  size: 50.0,
                  semanticLabel: 'Text to announce in accessibility modes',
                ),
                _sourceAndDesination(
                    '',
                    status
                        ? 'Gracias por confiar en nosotros'
                        : 'Error inesperado'),
                _buttons(),
              ],
            )));
  }

  Widget _buttons() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _button('Finalizar', status ? Colors.green : Colors.redAccent),
        ],
      ),
    );
  }

  Widget _button(String name, Color nameColor) {
    return Expanded(
      child: Container(
        child: RaisedButton(
          hoverElevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          padding: EdgeInsets.symmetric(vertical: 20),
          onPressed: () {
            SystemNavigator.pop();
          },
          child: Text(name, style: TextStyle(fontSize: 20)),
          color: nameColor,
          textColor: Colors.white,
        ),
      ),
    );
  }

  Widget _sourceAndDesination(String title, String subTitle) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListTile(
        title: Text(title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
            textAlign: TextAlign.center),
        subtitle: Text(subTitle,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
      ),
    );
  }
}
