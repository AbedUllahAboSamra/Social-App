class PostModel {
  dynamic name;
  dynamic uId;
  dynamic image;
  dynamic dataTime;
  dynamic postImage;
  dynamic text;
  dynamic isEmailVerified;

  PostModel({
    this.dataTime,
    this.postImage,
    this.name,
    this.uId,
    this.image,
    this.text,
    this.isEmailVerified,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    dataTime = json['dataTime'];
    text = json['text'];
    name = json['name'];
    postImage = json['postImage'];
    uId = json['uId'];
    image = json['image'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'dataTime': dataTime,
      'text': text,
      'name': name,
      'postImage': postImage,
      'uId': uId,
      'image': image,
      'isEmailVerified': isEmailVerified,
    };
  }
}
