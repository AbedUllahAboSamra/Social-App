import 'package:app_social/layout/social/cubit/cubit.dart';
import 'package:app_social/layout/social/socisl_layout.dart';
import 'package:app_social/modules/social_register/social_rsgister_screen.dart';
import 'package:app_social/shared/components/compoents.dart';
import 'package:app_social/shared/components/constants.dart';
import 'package:app_social/shared/network/remote/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'cubit/SocialLoginCubit.dart';
import 'cubit/SocialLoginState.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginState>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            showToast(text: state.error, state: ToastStates.ERROR);
          } else if (state is SocialLoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              SocialCubit.get(context).getUserData().then((value) {
                SocialCubit.get(context).getPostMy().then((value) {
                  navigateAndFinish(context, SocialLayout());
                });
                
              }).catchError((error) {
                print(error.toString());
              });
            });
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
                      'asset/images/main_top.png',
                      width: size.width * 0.35,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Image.asset(
                      'asset/images/login_bottom.png',
                      width: size.width * 0.4,
                    ),
                  ),
                  SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "LOGIN",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: size.height * 0.03),
                          SvgPicture.asset(
                            "asset/icons/login.svg",
                            height: size.height * 0.35,
                          ),
                          SizedBox(height: size.height * 0.03),
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
                                  SocialLoginCubit.get(context).isPassword,
                              size: size,
                              controller: password,
                              type: TextInputType.visiblePassword,
                              stringError: 'please enter your password',
                              hintText: 'Password',
                              prefix: Icons.lock,
                              suffix: SocialLoginCubit.get(context).suffix,
                              suffixPressed: () {
                                SocialLoginCubit.get(context)
                                    .changePasswordVisibility();
                              }),
                          if (state is! SocialLoginLoadingState)
                            DefaultBotton(
                                size: size,
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    SocialLoginCubit.get(context).userLogin(
                                        email: email.text,
                                        password: password.text);
                                  }
                                },
                                text: 'LOGIN')
                          else
                            Center(
                              child: CircularProgressIndicator(
                                color: kPrimaryColor,
                              ),
                            ),
                          SizedBox(height: size.height * 0.03),
                          DefaultText(
                            login: true,
                            context: context,
                            widgetTo: ResgisterScreen(),
                          ),
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

// import 'package:flutter/material.dart';
//
// class SocialLoginScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('asset/images/Ah2.png'),
//             fit: BoxFit.contain,
//           ),
//         ),
//         child: Padding(
//           padding: EdgeInsets.only(top: 120, left: 12, right: 12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "LOGIN",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 33,
//                 ),
//               ),
//               SizedBox(
//                 height: 8,
//               ),
//               Text(
//                 'login now to browse our hot offers',
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.white,
//                 ),
//               ),
//               SizedBox(
//                 height: 100,
//               ),
//               Center(
//                 child: Container(
//                   width: 330,
//                   height: 45,
//                   decoration: BoxDecoration(
//                     color: Color.fromARGB(133, 181, 210, 235),
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: TextField(
//                     decoration: InputDecoration(
//                       icon: Icon(Icons.email),hintText: 'email@gmail.com',
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20.0,),
//               Center(
//                 child: Container(
//                   width: 330,
//                   height: 45,
//                   decoration: BoxDecoration(
//                     color: Color.fromARGB(133, 181, 210, 235),
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: TextField(
//                     keyboardType: TextInputType.visiblePassword,
//                     decoration: InputDecoration(
//                       icon: Icon(Icons.lock),hintText: 'Password',
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
// // Widget build(BuildContext context) {
// //   return Scaffold(
// //     body: Container(
// //       decoration: BoxDecoration(
// //         image: DecorationImage(
// //           image: AssetImage('asset/images/Ah1.jpg'),
// //         ),
// //       ),
// //       child: Center(
// //         child: Padding(
// //           padding: EdgeInsets.only(top: 10, bottom: 150),
// //           child: Column(
// //             children: [
// //               AnimatedTextKit(
// //                 animatedTexts: [
// //                   TyperAnimatedText(
// //                     "Roman Developer",
// //                     textStyle: const TextStyle(
// //                       fontSize: 45,
// //                       fontFamily: "Insp",
// //                       wordSpacing: 8,
// //                       fontWeight: FontWeight.bold,
// //                       fontStyle: FontStyle.italic,
// //                     ),
// //                     speed: Duration(seconds: 2),
// //                   ),
// //                 ],
// //               ),
// //               Container(
// //                 width: 45,
// //                 height: 45,
// //                 decoration: BoxDecoration(
// //                   shape: BoxShape.circle,
// //                   border: Border.all(color: Colors.white,width: 4),
// //                 ),
// //                 child: InkWell(
// //                   onTap: (){
// //                     navigateTo(context,widget: );
// //                   },
// //                   child:Image(
// //                     image: AssetImage('asset/images/Ah2.jpg'),
// //                     color: Colors.white,
// //                     width: 20.0,
// //                     height: 20.0,
// //                   ),),
// //               )
// //             ],
// //           ),
// //         ),
// //       ),
// //     ),
// //   );
// // }
// }
