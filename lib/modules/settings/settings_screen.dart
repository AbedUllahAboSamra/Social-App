import 'package:app_social/layout/social/cubit/cubit.dart';
import 'package:app_social/layout/social/cubit/states.dart';
import 'package:app_social/modules/edit_profile/edit_profile_screen.dart';
import 'package:app_social/shared/components/compoents.dart';
import 'package:app_social/shared/styles/icon_broken.dart';
import 'package:app_social/shared/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/layoutfollower/layoutfollower_Screen.dart';
import '../../models/Post_model/post_model.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Builder(builder: (context) {
      //SocialCubit.get(context).getFollowres();

      return BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = SocialCubit.get(context).usermodel;
          var cubit = SocialCubit.get(context);
          // print(model?.coverimage);
          //print(model!.image);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: size.height * 0.29,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Container(
                            height: size.height * 0.21,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                  '${model!.coverimage}',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        CircleAvatar(
                          radius: size.height * 0.08,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          child: CircleAvatar(
                            radius: size.height * 0.077,
                            backgroundImage: NetworkImage('${model.image}'),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    '${model.name}',
                    style: black20Bold(),
                  ),
                  Text(
                    '${model.bio}',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              //navigateTo(context, widget: SocialLayoutFoolower());
                            },
                            child: Column(children: [
                              Text(
                                '${SocialCubit.get(context).postModelmy.length}',
                                style: black20Bold(),
                              ),
                              Text(
                                'Post',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ]),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              navigateTo(context,
                                  widget: SocialLayoutFoolower());
                            },
                            child: Column(children: [
                              Text(
                                '${SocialCubit.get(context).followres.length}',
                                style: black20Bold(),
                              ),
                              Text(
                                'Followres',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ]),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              navigateTo(context,
                                  widget: SocialLayoutFoolower());
                            },
                            child: Column(children: [
                              Text(
                                '${SocialCubit.get(context).followings.length}',
                                style: black20Bold(),
                              ),
                              Text(
                                'Followings',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          SocialCubit.get(context).changeBottomusers();
                        },
                        child: Icon(
                          IconBroken.Add_User,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            navigateTo(context, widget: EditProfileScreen());
                          },
                          child: Text('Edit profile'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  // Text(
                  //   'Welcome to Ahmed posts',
                  //   style:
                  //       TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
                  // ),
                  if (cubit.postModelmy.length > 0)
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => buildPostItem(
                          context,
                          size,
                          cubit.postModelmy[index],
                          cubit.usermodel!.image,
                          index,
                          state),
                      itemCount: cubit.postModelmy.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(
                        height: 5.0,
                      ),
                    ),
                  SizedBox(
                    height: 8.0,
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  Widget buildPostItem(
          context, Size size, PostModel model, image, index, State) =>
      Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 7.0,
        margin: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage(
                      '${SocialCubit.get(context).usermodel!.image}',
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.04,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${SocialCubit.get(context).usermodel!.name}',
                            style: TextStyle(
                              height: 1.3,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          if (model.isEmailVerified)
                            Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 16.0,
                            ),
                        ],
                      ),
                      Text(
                        '${model.dataTime}',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(height: 1.3),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_horiz,
                      size: 22.0,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: Container(
                  height: 1.0,
                  width: double.infinity,
                  color: Color.fromARGB(255, 201, 207, 201),
                ),
              ),
              Text(
                "${model.text}",
              ),
              if (model.postImage != '')
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    height: size.height * 0.21,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        4.0,
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                          '${model.postImage}',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7.0),
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Heart,
                              size: 22.0,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 3.0,
                            ),
                            Text(
                              '${SocialCubit.get(context).Like[index]}',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              IconBroken.Chat,
                              size: 22.0,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              width: 3.0,
                            ),
                            Text(
                              '0 comment',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  height: 1.0,
                  width: double.infinity,
                  color: Color.fromARGB(255, 201, 207, 201),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 17.0,
                            backgroundImage: NetworkImage(
                              '${image}',
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.04,
                          ),
                          Text(
                            'wrint a comment ... ',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      SocialCubit.get(context).likePost(
                          SocialCubit.get(context).postId[index],
                          SocialCubit.get(context).usermodel!.uId);
                      SocialCubit.get(context).getLikes(
                          SocialCubit.get(context).postId[index],
                          index,
                          SocialCubit.get(context).usermodel!.uId);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Heart,
                            size: 22.0,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 3.0,
                          ),
                          Text(
                            'Like',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 7.0,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.ios_share_outlined,
                            size: 22.0,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 1.0,
                          ),
                          Text(
                            'Share',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
