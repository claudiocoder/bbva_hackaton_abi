import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class SignatureScrenn extends StatefulWidget {
  @override
  _SignatureScrennState createState() => _SignatureScrennState();
}

class _SignatureScrennState extends State<SignatureScrenn> {
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
            children: <Widget>[
              Signature(
                controller: _controller,
                height: MediaQuery.of(context).size.height * .80,
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
                                  appBar: AppBar(),
                                  body: Center(
                                      child: Container(
                                          color: Colors.grey[300],
                                          child: Image.memory(data))),
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
