import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:io' as io;
import '../../http/send_service.dart' as sendServcie;

enum TypeAudio { play, pause, stop }

class AudioPage extends StatefulWidget {
  const AudioPage({Key key}) : super(key: key);

  @override
  _AudioPageState createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  FlutterAudioRecorder recorder;
  AudioPlayer audioPlayer = AudioPlayer();
  bool stateButton = false;
  IconData play = Icons.play_arrow;
  IconData stop = Icons.stop;
  IconData done = Icons.done;
  bool check = false;
  Recording _current;
  String base64String;
  //final recorder = FlutterAudioRecorder("prueba_audio", audioFormat: AudioFormat.WAV);

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 20.0),
                height: MediaQuery.of(context).size.height * .50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Color(0xFF14549C), Color(0xFF145466)]),
                ),
                child: Column(
                  children: [
                    _title(),
                    _text(),
                    _graph(),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top:20),
                child: _botones(),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        color: Colors.transparent,
        width: 75,
        height: 75,
        child: check
            ? FloatingActionButton(
                backgroundColor: Color(0xFF14549C),
                onPressed: () {
                  final send = new sendServcie.SendInfo(
                      base64String, '123456789', 'audio');
                },
                child: Icon(
                  done,
                  size: 60,
                  color: Colors.white,
                ),
              )
            : Container(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _init() async {
    if (await FlutterAudioRecorder.hasPermissions) {
      String customPath = '/flutter_audio_recorder_';
      io.Directory appDocDirectory;
//        io.Directory appDocDirectory = await getApplicationDocumentsDirectory();
      if (io.Platform.isIOS) {
        appDocDirectory = await getApplicationDocumentsDirectory();
      } else {
        appDocDirectory = await getExternalStorageDirectory();
      }

      // can add extension like ".mp4" ".wav" ".m4a" ".aac"
      customPath = appDocDirectory.path +
          customPath +
          DateTime.now().millisecondsSinceEpoch.toString();

      // .wav <---> AudioFormat.WAV
      // .mp4 .m4a .aac <---> AudioFormat.AAC
      // AudioFormat is optional, if given value, will overwrite path extension when there is conflicts.
      recorder = FlutterAudioRecorder(customPath, audioFormat: AudioFormat.AAC);

      await recorder.initialized;
    }
  }

  Widget _botones() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buttonAction(play, !stateButton ? _play : null, Colors.green),
          _buttonAction(stop, stateButton ? _stop : null, Colors.red)
        ],
      ),
    );
  }

  Widget _buttonAction(IconData name, action, Color nameColor) {
    return RaisedButton(
      padding: EdgeInsets.all(25.0),
      child: Icon(name, size: 40),
      color: nameColor,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(120),
      ),
      onPressed: action,
      disabledColor: Colors.grey,
    );
  }

  _play() async {
    if (await FlutterAudioRecorder.hasPermissions) {
      await recorder.start();
      check = false;
      var recording = await recorder.current(channel: 0);
      setState(() {
        stateButton = true;
        _current = recording;
      });
    }
  }

  _stop() async {
    //await recorder.resume();
    var result = await recorder.stop();
    setState(() {
      play = Icons.replay;
      stateButton = false;
      check = true;
    });
    final file = io.File(result.path);
    file.openRead();
    List<int> fileBytes = await file.readAsBytes();
    base64String = base64Encode(fileBytes);
    //sendInfo(base64String);
    //final fileString = 'data:audio/mp3;base64,$base64String';
  }

  Widget _graph() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      height: 150,
      child: stateButton
          ? Image(
              image: AssetImage('assets/images/onda.gif'),
            )
          : Divider(
              color: Colors.white,
            ),
    );
  }

  Widget _text() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: Text(
          'Hola Mundo',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: 35,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w300,
              letterSpacing: 0.5,
              wordSpacing: 2),
        ),
      ),
    );
  }

  Widget _title() {
    final double size = 20;
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: RichText(
          textAlign: TextAlign.justify,
          text: TextSpan(
            children: [
              TextSpan(text: "Oprima ", style: styleText(size)),
              spanIcon(size, play),
              TextSpan(
                  text: ", repita la siguiente frase y oprima ",
                  style: styleText(size)),
              spanIcon(size, stop),
              TextSpan(
                  text: ". Para finalizar oprima ", style: styleText(size)),
              spanIcon(size, done)
            ],
          ),
        ));
  }

  styleText(double size) {
    return TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w600,
        wordSpacing: 2,
        letterSpacing: 0.5);
  }

  spanIcon(double size, IconData nameIcon) {
    return WidgetSpan(
      child: Icon(
        nameIcon,
        size: 22,
        color: Colors.white,
      ),
    );
  }
}
