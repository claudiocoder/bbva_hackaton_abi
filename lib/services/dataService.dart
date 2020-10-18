import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class DataService {

  String emoji, text, type;

  getData() {
 return {
   "text": this.text,
   "emoji": this.emoji,
   "type": this.type
 };
  }

  void setData(type, emoji, text){
    this.emoji = emoji;
    this.text = text;
    this.type = type;

    print(getData());
  }

}