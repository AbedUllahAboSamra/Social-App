import 'package:app_social/layout/social/cubit/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/addPost/newPost_screen.dart';
import '../../shared/components/compoents.dart';
import '../../shared/styles/icon_broken.dart';
import '../social/cubit/states.dart';

class SocialLayoutFoolower extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        var boaedController = PageController();
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.usermodel!.name),
            // actions: [
            //   IconButton(
            //     onPressed: () {},
            //     icon: Icon(IconBroken.Notification),
            //   ),
            //   IconButton(
            //     onPressed: () {},
            //     icon: Icon(IconBroken.Search),
            //   ),
            // ],
          ),
          body: Column(
            children: [
              Row(children: [
                Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Text('${cubit.titleFollower[0]}'))),
                        Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Text('${cubit.titleFollower[1]}'))),
              ]),
              PageView.builder(
                controller: boaedController,
                onPageChanged: (int index) {
                  cubit.changeFollowerScreen(index);
                },
                physics: const BouncingScrollPhysics(),
                //تطير لون النطة في الحركة
                itemBuilder: (context, index) =>
                    cubit.screenFollower[cubit.currenindexfollower],
                itemCount: 2,
              ),
            ],
          ),
        );
      },
    );
  }
}
