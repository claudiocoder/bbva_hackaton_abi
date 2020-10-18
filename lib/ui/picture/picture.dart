import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hackaton_bbva_abi/services/authService.dart';
import 'package:hackaton_bbva_abi/ui/login/Login.dart';
import 'package:hackaton_bbva_abi/http/send_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hackaton_bbva_abi/widgets/CardImage.dart';

class PictureScreen extends StatefulWidget {
  @override
  _PictureScreenState createState() => _PictureScreenState();
}

class _PictureScreenState extends State<PictureScreen> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
      maxWidth: MediaQuery.of(context).size.width * .80,
      maxHeight: MediaQuery.of(context).size.height * 80,
    );
    final bytes = await pickedFile.readAsBytes();
    String base64String = base64Encode(bytes);
    // final send = new SendInfo(base64String, '123456789', 'image');
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
    // await send.sendInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 30.0),
            height: MediaQuery.of(context).size.height * .50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Color(0xFF14549C), Color(0xFF145466)]),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                  child: Text(
                    "Hagamos una validación con tu rostro",
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 30.0),
                  child: Center(
                    child: _image == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Imita al gato',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.0),
                              ),
                            ],
                          )
                        : CircleAvatar(
                            radius: 70.0,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              backgroundImage: new FileImage(_image),
                              radius: 65.0,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * .25,
            child: CardImage('assets/images/cat.png'),
          ),
          Container(
            padding: EdgeInsets.only(top: 30.0),
            height: MediaQuery.of(context).size.height * .1,
            child: MaterialButton(
              height: 58,
              minWidth: 340,
              color: Color(0xFF14549C),
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(12),
              ),
              onPressed: () {},
              child: Text(
                "Validar",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Tomar Foto',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
