import 'dart:io';
import 'dart:math';

import 'package:app_social/layout/social/cubit/states.dart';
import 'package:app_social/models/Social_model/scoial_user_model.dart';
import 'package:app_social/models/message_Model/Message_Model.dart';
import 'package:app_social/modules/chats/chats_screen.dart';
import 'package:app_social/modules/feeds/feeds_screeen.dart';
import 'package:app_social/modules/settings/settings_screen.dart';
import 'package:app_social/modules/users/users_screen.dart';
import 'package:app_social/shared/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/Post_model/post_model.dart';
import '../../../models/firends_model/firends_model.dart';
import '../../../modules/Followers/Followers_screen.dart';
import '../../../modules/Followings/Followings_Screen.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? usermodel;
  Future<void> getUserData() async {
    print('1');
    emit(SocialGetUserLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      // print(value.data());
      usermodel = SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currenIndex = 0;
  int currenindex = 0;
  int currenindexfollower = 0;

  List<String> title = [
    'home',
    'Chat',
    'Users',
    'Setting',
  ];
  List<String> titleFollower = [
    'Followers',
    'Followings',
  ];

  List<Widget> screen = [
    FeedsScreen(),
    ChatsScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<Widget> screenFollower = [
    FollowersScreen(),
    FollowingsScreen(),
  ];
    void changeBottomNac(int index) {
    if (index == 1) getUsers();
    if (index > 2) {
      currenindex = index - 1;
      currenIndex = index;
    } else {
      currenIndex = index;
      currenindex = index;
    }
    emit(SocialChangeBottomNavState());
  }

  void changeBottomusers() {
    currenIndex = 3;
    emit(SocialChangeBottomUsersState());
  }
  
  void changeFollowerScreen(int index) {
    currenindexfollower = index;
    emit(SocialChangeFollowerScerrnState());
  }


  List<String> followres = [];
  Future<void> getFollowres() async {
    print('2');
    emit(SocialFollowresLiognState());
    followres = [];
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) async {
      value.docs.forEach((element) async {
        if (element.id == usermodel!.uId) {
          await element.reference.collection('followres').get().then((value) {
            value.docs.forEach((element) {
              followres.add(element.id);
              print('aaaaaaaaaa${element.id}');
              emit(SocialFollowresSuccessState());
            });
          }).catchError((onError) {
            print(onError.toString());
          });
        }
      });
      getPostAll();
    }).catchError((erorr) {
      print('aaaa${erorr.toString()}');
    });
    print('endaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
  }

  List<String> followings = [];
  void getFollowings() {
    followings = [];
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.id == usermodel!.uId) {
          element.reference.collection('followres').get().then((value) {
            value.docs.forEach((element) {
              print(element.id);
              followres.add(element.id);
              emit(SocialFollowingsSuccessState());
            });
          }).catchError((error) {
            emit(SocialFollowingsErrorState());
          });
        }
      });
    }).catchError((error) {
      emit(SocialFollowingsErrorState());
    });
  }

  List<PostModel> postModelmy = [];
  Future<void> getPostMy() async {
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.id == usermodel!.uId) {
          element.reference
              .collection('postmy')
              .orderBy('dataTime')
              .snapshots()
              .listen((event) {
            event.docs.forEach((element) {
              element.reference.collection('likes').get().then((value) {
                Like.add(value.docs.length);
                postModelmy.add(PostModel.fromJson(element.data()));
                postId.add(element.id);
                emit(SocialGetPostmySuccessState());
              }).catchError((error) {});
            });
          });
        }
      });
    });
  }

  List<PostModel> postModels = [];
  // getPostUser() {
  //   FirebaseFirestore.instance.collection('users').get().then((value) {
  //     value.docs.forEach((element) {
  //       if (element.id == usermodel!.uId) {
  //         element.reference
  //             .collection('posts')
  //             .orderBy('dataTime')
  //             .snapshots()
  //             .listen((event) {
  //           event.docs.forEach((element) {
  //             postModel.add(PostModel.fromJson(element.data()));
  //           });
  //         });
  //       }
  //     });
  //   });
  // }



  String profileImageUrl = '';
  String coverImageUrl = '';
  String StringProfileImage = '';
  String StringcoverImage = '';
  final avatarRef = FirebaseStorage.instance.ref();
  File? profileImage;
  File? coverImage;
  final ImagePicker picker = ImagePicker();

  Future<void> getProfileImage() async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      StringProfileImage = '${Uri.file(profileImage!.path).pathSegments.last}';
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  Future<void> getCoverImage() async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    print(pickedFile);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      StringcoverImage = '${Uri.file(coverImage!.path).pathSegments.last}';
      print('hhhhhhhhhhhhhhhhhhhh$StringcoverImage');
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  Future<void> UpProfileImage() async {
    await avatarRef
        .child('users/$StringProfileImage')
        .putFile(profileImage!)
        .then((p0) async {
      await p0.ref.getDownloadURL().then((value) {
        profileImageUrl = value;
        print(profileImageUrl);
        //emit(SocialUoloadProfileSuccessState());
      }).catchError((error) {
        print(error);
        emit(SocialUoloadProfileErrorState());
      });
    }).catchError((error) {
      emit(SocialUoloadProfileErrorState());
      print(error);
    });
    print(profileImageUrl);
  }

  Future<void> UpcoverImage() async {
    await avatarRef
        .child('users/$StringcoverImage')
        .putFile(coverImage!)
        .then((p0) async {
      await p0.ref.getDownloadURL().then((value) {
        coverImageUrl = value;
        //emit(SocialUoloadCoverSuccessState());
      }).catchError((error) {
        print(error);
        emit(SocialUoloadCoverErrorState());
      });
    }).catchError((error) {
      emit(SocialUoloadCoverErrorState());
      print(error);
    });
    print('AAAAAAAAAAAAAAAAAAAAAAAAA$coverImageUrl');
  }

  Future<void> updataUser({
    required String name,
    required String phone,
    required String bio,
  }) async {
    emit(SocialUsersUpdataLoadingState());
    if (coverImage != null) await UpcoverImage();
    if (profileImage != null) await UpProfileImage();
    if (coverImage != null && profileImage == null) {
      updataUsercoverImage(
          bio: bio, name: name, phone: phone, coverImage: coverImageUrl);
    } else if (coverImage == null && profileImage != null) {
      updataUserprofileImage(
        bio: bio,
        name: name,
        phone: phone,
        profileImage: profileImageUrl,
      );
    } else if (coverImage != null && profileImage != null) {
      updataUsercoverImageAndprofileImage(
          bio: bio,
          name: name,
          phone: phone,
          coverImage: coverImageUrl,
          profileImage: profileImageUrl);
    } else {
      upBataUser(bio: bio, name: name, phone: phone);
    }
  }

  void upBataUser({
    required String name,
    required String phone,
    required String bio,
    String? profileImage,
    String? coverImage,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      bio: bio,
      phone: phone,
      // image: profileImage == null ? usermodel!.image : profileImage,
      // coverimage: coverImage == null ? usermodel!.coverimage : coverImage,
      image: usermodel!.image,
      coverimage: usermodel!.coverimage,
      email: usermodel!.email,
      isEmailVerified: usermodel!.isEmailVerified,
      password: usermodel!.password,
      uId: usermodel!.uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(usermodel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUsersUpdataErrorState());
    });
  }

  void updataUserprofileImage({
    required String name,
    required String phone,
    required String bio,
    required String profileImage,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      bio: bio,
      phone: phone,
      image: profileImage,
      coverimage: usermodel!.coverimage,
      email: usermodel!.email,
      isEmailVerified: usermodel!.isEmailVerified,
      password: usermodel!.password,
      uId: usermodel!.uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(usermodel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUsersUpdataErrorState());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(usermodel!.uId)
        .collection('postmy')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference.update({
          'image': model.image,
          'name': model.name,
        });
      });
    }).catchError((error) {
      emit(SocialUsersUpdataErrorState());
    });
  }

  void updataUsercoverImage({
    required String name,
    required String phone,
    required String bio,
    required String coverImage,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      bio: bio,
      phone: phone,
      image: usermodel!.image,
      coverimage: coverImage,
      email: usermodel!.email,
      isEmailVerified: usermodel!.isEmailVerified,
      password: usermodel!.password,
      uId: usermodel!.uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(usermodel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUsersUpdataErrorState());
    });
  }

  void updataUsercoverImageAndprofileImage({
    required String name,
    required String phone,
    required String bio,
    required String profileImage,
    required String coverImage,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      bio: bio,
      phone: phone,
      image: profileImage,
      coverimage: coverImage,
      email: usermodel!.email,
      isEmailVerified: usermodel!.isEmailVerified,
      password: usermodel!.password,
      uId: usermodel!.uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(usermodel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(SocialUsersUpdataErrorState());
    });
  }

  File? postImage;
  String? StringPostImage;
  String? StringPostImageUlr;

  Future<void> getPostImage() async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      StringPostImage = '${Uri.file(postImage!.path).pathSegments.last}';
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialPostImagePickedErrorState());
    }
  }

  Future<void> createNewPost({
    required String dataTime,
    String? text,
  }) async {
    emit(SocialCratePostLoadingState());
    await avatarRef
        .child('posts/$StringPostImage')
        .putFile(postImage!)
        .then((p0) async {
      await p0.ref.getDownloadURL().then((value) {
        StringPostImageUlr = value;
        cPost(dataTime: dataTime, text: text, postiamge: StringPostImageUlr);
        emit(SocialCratePostSuccessState());
      }).catchError((error) {
        print(error);
        emit(SocialCratePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCratePostErrorState());
      print(error);
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void createPost({
    required String dataTime,
    String? text,
    String? postiamge,
  }) {
    PostModel model = PostModel(
      name: usermodel!.name,
      text: text,
      dataTime: dataTime,
      image: usermodel!.image,
      uId: usermodel!.uId,
      postImage: postiamge ?? '',
      isEmailVerified: usermodel!.isEmailVerified,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      getPosts();
      emit(SocialCratePostSuccessState());
    }).catchError((error) {
      emit(SocialCratePostErrorState());
    });
  }

  Future<void> cPost({
    required String dataTime,
    String? text,
    String? postiamge,
  }) async {
    PostModel model = PostModel(
      name: usermodel!.name,
      text: text,
      dataTime: dataTime,
      image: usermodel!.image,
      uId: usermodel!.uId,
      postImage: postiamge ?? '',
      isEmailVerified: usermodel!.isEmailVerified,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(usermodel!.uId)
        .collection('postmy')
        .add(model.toMap())
        .then((value) {
      emit(SocialCratePostSuccessState());
    }).catchError((error) {
      emit(SocialCratePostErrorState());
    });
  }

  String text = '';
  void string(String s) {
    text = s;
    emit(SocialStringState());
  }

  // Map<String, String>? messagetext;
  // String message(String uId) {
  //   messagetext![uId] = Stringmessage;
  //   emit(SocialStringState());
  //   return '';
  // }
  String Stringmessage = '';
  void stringmessage(String s) {
    Stringmessage = s;
    emit(SocialStringState());
  }

  void removeStringmessage() {
    Stringmessage = '';
    emit(SocialStringState());
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<String> postId = [];
  List<int> Likes = [];
  List<int> Like = [];
  List<int> likeUser = [];
  List<String> postUserId = [];

  void getPosts() {
    emit(SocialGetPostLoadingState());
    postsId = [];
    posts = [];
    Likes = [];

    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          Likes.add(value.docs.length);
          postsId.add(element.id);
          //print(postsId[0]);
          posts.add(PostModel.fromJson(element.data()));
          emit(SocialGetPostSuccessState());
        }).catchError((error) {});
      });
      emit(SocialGetPostSuccessState());
    }).catchError((error) {
      emit(SocialGetPostErrorState());
    });
  }

  List<PostModel> post = [];
  // List<String> postId = [];
  // List<int> Like = [];
  Future<void> getPostsUsre({required String uid}) async {
    emit(SocialGetPostLoadingState());
    postUserId = [];
    post = [];
    likeUser = [];
    await FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.id == uid) {
          print(element.id);
          element.reference
              .collection('postmy')
              .orderBy('dataTime')
              .snapshots()
              .listen((event) {
            event.docs.forEach((element) {
              element.reference.collection('likes').get().then((value) {
                post.add(PostModel.fromJson(element.data()));
                likeUser.add(value.docs.length);
                postUserId.add(element.id);
                emit(SocialGetPostSuccessState());
              }).catchError((error) {});
            });
            emit(SocialGetPostSuccessState());
          });
        }
      });
    });
  }

  getLikes(String postId, int index, String? uid) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('postmy')
        .doc(postId)
        .collection('likes')
        .get()
        .then((value) {
      Likes[index] = value.docs.length;
      emit(SocialGetLikesSuccessState());
    }).catchError((error) {
      emit(SocialGetLikesErrorState());
    });
  }

  void likePost(
    String postId,
    String? uid,
  ) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('postmy')
        .doc(postId)
        .collection('likes')
        .doc(usermodel!.uId)
        .set({
          'like': true,
        })
        .then((value) {})
        .catchError((error) {});
  }

  List<SocialUserModel> users = [];
  void getUsers() {
    users = [];
    emit(SocialGetUsersModeLoadingState());

    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['uId'] != usermodel!.uId)
          users.add(SocialUserModel.fromJson(element.data()));
      });
      emit(SocialGetUsersModeSuccessState());
    }).catchError((error) {
      emit(SocialGetUsersModeErrorState());
    });
  }
//   void like(
//     String postId,
//   ) {
//     FirebaseFirestore.instance
//         .collection('posts')
//         .doc(postId)
//         .collection('likes')
//         .doc(usermodel!.uId)
//         .get()
//         .then((value) {
//       Map<String, dynamic>? a = value.data();
//       li = a!['like'];
//       print(li);
//     }).catchError((error) {});
//   }
// }

  void sendMessage({
    required String receiverId,
    required String text,
    required String dateTime,
  }) {
    MessageModel model = MessageModel(
      text: text,
      dataTime: dateTime,
      receiverId: receiverId,
      senderId: usermodel!.uId,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(usermodel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messges')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(usermodel!.uId)
        .collection('messges')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];
  void getMessages({required String receiverId}) {
    messages = [];
    FirebaseFirestore.instance
        .collection('users')
        .doc(usermodel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messges')
        .orderBy('dataTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
        print(element['text']);
      });
      emit(SocialGetMessageSuccessState());
    });
  }

  File? ImageMessage;
  String? StringImageMessage;
  Future<void> getImageMessage() async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    print(pickedFile);
    if (pickedFile != null) {
      ImageMessage = File(pickedFile.path);
      StringImageMessage = '${Uri.file(ImageMessage!.path).pathSegments.last}';
      print('hhhhhhhhhhhhhhhhhhhh$StringImageMessage');
      emit(SocialImageMessagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialImageMessagePickedErrorState());
    }
  }

  Future<void> getCameraImageMessage() async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );
    print(pickedFile);
    if (pickedFile != null) {
      ImageMessage = File(pickedFile.path);
      StringImageMessage = '${Uri.file(ImageMessage!.path).pathSegments.last}';
      print('hhhhhhhhhhhhhhhhhhhh$StringImageMessage');
      emit(SocialImageMessagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialImageMessagePickedErrorState());
    }
  }

  void sendFirend({
    required String receiverId,
    required String dateTime,
    required String image,
  }) {
    FirendsModel modelreceiver = FirendsModel(
      image: image,
      dataTime: dateTime,
      receiverId: receiverId,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(usermodel!.uId)
        .collection('followres')
        .doc(receiverId)
        .set(modelreceiver.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });

    FirendsModel model = FirendsModel(
      image: usermodel!.image,
      dataTime: dateTime,
      receiverId: usermodel!.uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('followings')
        .doc(usermodel!.uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  Future<void> getPostAll() async {
    emit(SocialGetPostLoadingState());
    postModels = [];
    await FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((eleme) {
        if (followres.contains(eleme.id) || eleme.id == usermodel!.uId) {
          eleme.reference
              .collection('postmy')
              .orderBy('dataTime', descending: true)
              .snapshots()
              .listen((event) {
            event.docs.forEach((element) {
              element.reference.collection('likes').get().then((value) {
                postModels.add(
                  PostModel.fromJson(element.data()),
                );
                Likes.add(value.docs.length);
                postsId.add(element.id);
                posts.add(PostModel.fromJson(element.data()));
                emit(SocialGetPostSuccessState());
              }).catchError((error) {});
              emit(SocialGetPostSuccessState());
            });
          });
          emit(SocialGetPostSuccessState());
        }
      });
    }).catchError((error) {
      print(error.toString());
    });
  }
}
