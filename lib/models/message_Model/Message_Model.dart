class MessageModel {
  dynamic senderId;
  dynamic receiverId;
  dynamic dataTime;
  dynamic text;

  MessageModel({
    this.dataTime,
    this.senderId,
    this.receiverId,
    this.text,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    dataTime = json['dataTime'];
    text = json['text'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'dataTime': dataTime,
      'text': text,
      'senderId': senderId,
      'receiverId': receiverId,
    };
  }
}
