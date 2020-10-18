


class DataService {

  String emoji, text, type;

  getData() {
    return {
      "text": this.text ?? '',
      "emoji": this.emoji ?? '',
      "type": this.type ?? 'ticket'
    };
  }

  void setData(type, emoji, text){
    this.emoji = emoji;
    this.text = text;
    this.type = type;

    print('###################>${getData()}');
  }

}