class FirendsModel {
  dynamic receiverId;
  dynamic dataTime;
  dynamic image;

  FirendsModel({
    this.dataTime,
    this.image,
    this.receiverId,
  });

  FirendsModel.fromJson(Map<String, dynamic> json) {
    dataTime = json['dataTime'];
    image = json['image'];
    receiverId = json['receiverId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'dataTime': dataTime,
      'image': image,
      'receiverId': receiverId,
    };
  }
}
