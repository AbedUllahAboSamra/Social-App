class SocialUserModel {
  dynamic email;
  dynamic password;
  dynamic name;
  dynamic phone;
  dynamic uId;
  dynamic image;
  dynamic coverimage;
  dynamic bio;
  dynamic isEmailVerified;

  SocialUserModel({
    this.email,
    this.password,
    this.name,
    this.phone,
    this.uId,
    this.image,
    this.coverimage,
    this.bio,
    this.isEmailVerified,
  });

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    coverimage = json['coverimage'];
    bio = json['bio'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
      'uId': uId,
      'image': image,
      'coverimage': coverimage,
      'bio': bio,
      'isEmailVerified': isEmailVerified
    };
  }
}
