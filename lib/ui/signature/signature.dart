import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:hackaton_bbva_abi/constants/font_family.dart';

class SignatureScreen extends StatefulWidget {
  @override
  _SignatureScreenState createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  // Initialise a controller. It will contains signature points, stroke width and pen color.
// It will allow you to interact with the widget
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 2.5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          body: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Color(0xFF14549C), Color(0xFF145466)]),
                ),
                padding: EdgeInsets.only(
                    top: 40.0, bottom: 30.0, left: 10.0, right: 10.0),
                child: Text(
                  '¿Me regalas tu firma?',
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                    fontFamily: FontFamily.roboto,
                  ),
                ),
              ),
              Signature(
                controller: _controller,
                height: MediaQuery.of(context).size.height * .70,
                width: MediaQuery.of(context).size.width,
                backgroundColor: Colors.white,
              ),
              Container(
                height: MediaQuery.of(context).size.height * .20,
                decoration: const BoxDecoration(color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    //SHOW EXPORTED IMAGE IN NEW ROUTE
                    IconButton(
                      icon: const Icon(Icons.check),
                      color: Colors.blue,
                      iconSize: 32.0,
                      onPressed: () async {
                        if (_controller.isNotEmpty) {
                          var data = await _controller.toPngBytes();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return Scaffold(
                                  backgroundColor: Colors.white,
                                  body: Column(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topRight,
                                              end: Alignment.bottomLeft,
                                              colors: [
                                                Color(0xFF14549C),
                                                Color(0xFF145466)
                                              ]),
                                        ),
                                        padding: EdgeInsets.only(
                                            top: 40.0,
                                            bottom: 30.0,
                                            left: 10.0,
                                            right: 10.0),
                                        child: Text(
                                          'Tu firma nos ayuda a proteger tus datos',
                                          style: TextStyle(
                                            fontSize: 25.0,
                                            color: Colors.white,
                                            fontFamily: FontFamily.roboto,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .70,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          color: Colors.white,
                                          child: Image.memory(data),
                                        ),
                                      ),
                                      MaterialButton(
                                        height: 58,
                                        minWidth: 340,
                                        color: Color(0xFF14549C),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(12),
                                        ),
                                        onPressed: () {},
                                        child: Text(
                                          "Confirmar",
                                          style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      },
                    ),
                    //CLEAR CANVAS
                    IconButton(
                      icon: const Icon(Icons.clear),
                      color: Colors.blue,
                      iconSize: 32.0,
                      onPressed: () {
                        setState(() => _controller.clear());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
