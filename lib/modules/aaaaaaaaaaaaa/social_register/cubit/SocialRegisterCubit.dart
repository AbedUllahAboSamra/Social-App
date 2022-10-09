import 'package:app_social/models/Social_model/scoial_user_model.dart';
import 'package:app_social/shared/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'SocialRegisterState.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterState> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
          print(value.user!.uid);
      userCreate(
          name: name,
          phone: phone,
          email: email,
          password: password,

          uId: value.user!.uid,);
       emit(SocialRegisterSuccessState(value.user!.uid));
    }).catchError((error) {
      print(uId);
      print('hhhhhhh');
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String uId,
  }) {
    SocialUserModel modle = SocialUserModel(
      email: email,
      password: password,
      phone: phone,
      name: name,
      uId: uId,
      bio: 'Wrint you bio',
      image: 'https://img.freepik.com/free-vector/delivery-service-customer-door_107791-11385.jpg',//الافتراضي
      coverimage: 'https://img.freepik.com/free-photo/two-beautiful-little-girls-walk-botanical-garden-surrounded-by-tropical-leaves-keep-secrets_98296-6641.jpg',
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users') //لو ما لقه بروح يكريته ويشتغل عليه
        .doc(modle.uId)
        .set(modle.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState(modle.uId));
    }).catchError((error) {
      emit(SocialCreateUseErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegisterChangePasswordVisibilityState());
  }
}
