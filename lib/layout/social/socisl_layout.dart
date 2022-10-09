import 'package:app_social/modules/addPost/newPost_screen.dart';
import 'package:app_social/shared/components/compoents.dart';
import 'package:app_social/shared/components/constants.dart';
import 'package:app_social/shared/network/remote/cache_helper.dart';
import 'package:app_social/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    uId = CacheHelper.getData(key: 'uId');
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        if (state is SocialNewPostState)
          navigateTo(context, widget: NewPostScreen());
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.title[cubit.currenindex]),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(IconBroken.Notification),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(IconBroken.Search),
              ),
            ],
          ),
          body: cubit.screen[cubit.currenindex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currenIndex,
            onTap: (index) {
              if (index == 2)
                navigateTo(context, widget: NewPostScreen());
              else
                cubit.changeBottomNac(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Home,
                ),
                label: 'Home',
                activeIcon: Icon(
                  IconBroken.Home,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Chat,
                ),
                label: 'Chat',
                activeIcon: Icon(
                  IconBroken.Chat,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Paper_Upload,
                ),
                label: 'Post',
                activeIcon: Icon(
                  IconBroken.Paper_Upload,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Location,
                ),
                label: 'Users',
                activeIcon: Icon(
                  IconBroken.Location,
                ),
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Setting,
                  ),
                  label: 'Setting',
                  activeIcon: Icon(
                    IconBroken.Setting,
                  ),
                  tooltip: 'aaa'),
            ],
          ),
        );
      },
    );
  }
}
