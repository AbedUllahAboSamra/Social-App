import 'package:app_social/shared/styles/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/social/cubit/cubit.dart';
import 'layout/social/cubit/states.dart';
import 'layout/social/socisl_layout.dart';
import 'modules/social_login_screen/social_login_screen.dart';
import 'shared/network/remote/cache_helper.dart';
import 'shared/components/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();

  uId = CacheHelper.getData(key: 'uId');
  Widget? widget;
  if (uId != null) {
    widget = SocialLayout();
  } else {
    widget = LoginScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp({required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialCubit()
        ..getUserData()
        ..getFollowres()
        //..getPosts()
        //..getPostAll()
        ..getUsers()
        ..getPostMy(),
      child: BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: ligthTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },
      ),
    );
  }
}
