import 'package:app_social/layout/social/cubit/cubit.dart';
import 'package:app_social/layout/social/socisl_layout.dart';
import 'package:app_social/modules/social_login_screen/social_login_screen.dart';
import 'package:app_social/shared/components/compoents.dart';
import 'package:app_social/shared/components/constants.dart';
import 'package:app_social/shared/network/remote/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'cubit/SocialRegisterCubit.dart';
import 'cubit/SocialRegisterState.dart';

class ResgisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
  var name = TextEditingController();
  var phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterState>(
        listener: (context, state) {
          if(state is SocialRegisterSuccessState){
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              SocialCubit.get(context).getUserData().then((value) {
                SocialCubit.get(context).getPostMy().then((value) {
                  navigateAndFinish(context, SocialLayout());
                });
              }).catchError((error) {
                print(error.toString());
              });
            });
          }else if(state is SocialRegisterErrorState){
            showToast(text: state.error, state: ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leadingWidth: 0,
              toolbarHeight: 0,
            ),
            body: Container(
              width: double.infinity,
              height: size.height,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Image.asset(
                      'asset/images/signup_top.png',
                      width: size.width * 0.35,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Image.asset(
                      'asset/images/main_bottom.png',
                      width: size.width * 0.25,
                    ),
                  ),
                  SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "SIGNUP",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: size.height * 0.03),
                          SvgPicture.asset(
                            "asset/icons/signup.svg",
                            height: size.height * 0.25,
                          ),
                          SizedBox(height: size.height * 0.03),
                          DefailTextFild(
                            size: size,
                            type: TextInputType.name,
                            stringError: 'please enter your user name',
                            hintText: 'User Name',
                            prefix: Icons.person,
                            controller: name,
                          ),
                          DefailTextFild(
                            size: size,
                            type: TextInputType.emailAddress,
                            stringError: 'please enter your email address',
                            hintText: 'Email Address',
                            prefix: Icons.person,
                            controller: email,
                          ),
                          DefailTextFild(
                            isPassword:
                                SocialRegisterCubit.get(context).isPassword,
                            size: size,
                            controller: password,
                            type: TextInputType.visiblePassword,
                            stringError: 'please enter your password',
                            hintText: 'Password',
                            prefix: Icons.lock,
                            suffix: SocialRegisterCubit.get(context).suffix,
                            suffixPressed: () {
                              SocialRegisterCubit.get(context)
                                  .changePasswordVisibility();
                            },
                          ),
                          DefailTextFild(
                            size: size,
                            controller: phone,
                            type: TextInputType.phone,
                            stringError: 'please enter your phone',
                            hintText: 'Phone',
                            prefix: Icons.phone,
                          ),
                          if(state is! SocialRegisterLoadingState) DefaultBotton(
                              size: size,
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  SocialRegisterCubit.get(context).userRegister(
                                      name: name.text,
                                      phone: phone.text,
                                      email: email.text,
                                      password: password.text);
                                }
                              },
                              text: 'SIGNUP'
                          )
                          else Center(child: CircularProgressIndicator(
                            color: kPrimaryColor,
                          ),),
                          SizedBox(height: size.height * 0.02),
                          DefaultText(
                              login: false,
                              context: context,
                              widgetTo: LoginScreen()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
