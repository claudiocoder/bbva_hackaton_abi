import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
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
    print(base64String);  
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } 
    });
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
