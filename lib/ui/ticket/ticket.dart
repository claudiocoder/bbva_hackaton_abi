import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_ticket_widget/flutter_ticket_widget.dart';
import 'package:hackaton_bbva_abi/services/dataService.dart';
import 'package:intl/intl.dart';

class TicketPage extends StatefulWidget {
  TicketPage({Key key}) : super(key: key);

  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  final dataService = DataService();
  var info;
  String arg;

  @override
  void initState() {
    super.initState();
    info = dataService.getData();
  }

  @override
  Widget build(BuildContext context) {
    arg = ModalRoute.of(context).settings.arguments;
    print('INFO: ${info}');
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromRGBO(6, 35, 72, 1),
          body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              children: [
                _template(info['source'], info['destination'], 125554.0)
              ])),
    );
  }

  Widget _template(String source, String destination, amount) {
    return FlutterTicketWidget(
        width: 350.0,
        height: 450.0,
        isCornerRounded: true,
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _sourceAndDesination('Origen', 'Cuenta de Efectivo **752'),
                _sourceAndDesination('Destino', 'Pago a Sat (Desde la aplicacion movil)'),
                Container(
                  color: Color.fromRGBO(6, 35, 72, 1),
                  margin: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                  child: Divider(
                    height: 1,
                    color: Color.fromRGBO(6, 35, 72, 1),
                  ),
                ),
                _amount(amount),
                _buttons(),
              ],
            )));
  }

  Widget _buttons() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _button('Rechazar', Colors.red, () {}),
          _button('Aceptar', Colors.green,
              () => Navigator.of(context).pushReplacementNamed(arg)),
        ],
      ),
    );
  }

  Widget _button(String name, Color nameColor, Function action) {
    return Expanded(
      child: Container(
        child: RaisedButton(
          hoverElevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          padding: EdgeInsets.symmetric(vertical: 20),
          onPressed: action,
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
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
        subtitle: Text(subTitle,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.normal),
            textAlign: TextAlign.center),
      ),
    );
  }

  Widget _amount(double amount) {
    final money = NumberFormat.simpleCurrency().format(amount);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            money,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
