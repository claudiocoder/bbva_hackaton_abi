import 'dart:async';

class DataService {
  String emoji, text, type;
  String source, destination,amount;

  getData() {
    return {
      "text": this.text ?? '',
      "emoji": this.emoji ?? '',
      "type": this.type ?? '',
      "source": this.source ?? '',
      "destination": this.destination ?? '',
      "amount": this.amount ?? ''
    };
  }

  void setData(type, emoji, text, source, destination, amount) {
    this.emoji = emoji;
    this.text = text;
    this.type = type;
    this.destination = destination;
    this.source = source;
    this.amount = amount;

    print('###################>${getData()}');
  }
}
