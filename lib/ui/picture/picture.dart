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
      maxWidth: 450.0,
      maxHeight: 450.0,
    );
    final bytes = await pickedFile.readAsBytes();
    String base64String = base64Encode(bytes);
    final send = new SendInfo(base64String, '123456789', 'image');
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
    await send.sendInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          CardImage('assets/images/happy.jpg'),
          Center(
            child: _image == null
                ? Text('Ninguna Imagen seleccionada')
                : Image.file(_image),
          ),
          RaisedButton(
            onPressed: (){
              AuthService().signOut();
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Login()),
              );
            },
            child: Text("Cerrar Sesion",
              style: TextStyle(color: Colors.white),),
            elevation: 7.0,
            color: Colors.blue,
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
