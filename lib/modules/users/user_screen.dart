import 'package:app_social/layout/social/cubit/cubit.dart';
import 'package:app_social/layout/social/cubit/states.dart';
import 'package:app_social/models/Social_model/scoial_user_model.dart';
import 'package:app_social/shared/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/Post_model/post_model.dart';
import '../../shared/components/compoents.dart';
import '../../shared/styles/icon_broken.dart';
import '../chats/chats_user_screen.dart';

class UserScreen extends StatelessWidget {
  SocialUserModel modelu;
  UserScreen({required this.modelu});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Builder(builder: (context) {
      SocialCubit.get(context).getPostsUsre(uid: modelu.uId);
      return BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('${modelu.name}'),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  IconBroken.Arrow___Left_2,
                ),
              ),
            ),
            body: Padding(
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
                                    '${modelu.coverimage}',
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
                              backgroundImage: NetworkImage('${modelu.image}'),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      '${modelu.name}',
                      style: black20Bold(),
                    ),
                    SizedBox(
                      height: 7.0,
                    ),
                    Text(
                      '${modelu.bio}',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      children: [
                        Container(
                          height: size.height * 0.05,
                          width: size.width * 0.45,
                          child: OutlinedButton(
                            onPressed: () {
                              SocialCubit.get(context).post[1].postImage;
                              navigateTo(
                                context,
                                widget: ChatUserScreen(userModel: modelu),
                              );
                            },
                            child: Text('message'),
                          ),
                        ),
                        Spacer(),
                        follower(size, context),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      'Welcome to ${modelu.name} posts',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    if (cubit.post.length > 0)
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => buildPostItem(
                          context,
                          size,
                          cubit.post[index],
                          cubit.usermodel!.image,
                          index,
                          state,
                        ),
                        itemCount: cubit.post.length,
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
            ),
          );
        },
      );
    });
  }

  Widget follower(Size size, context) {
    if (5 == 4)
      return Container(
        height: size.height * 0.05,
        width: size.width * 0.45,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: ElevatedButton(
            onPressed: () {},
            child: Text(
              'Follow',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    return Container(
      height: size.height * 0.05,
      width: size.width * 0.45,
      child: OutlinedButton(
        onPressed: () {},
        child: Text('Follower'),
      ),
    );
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
                      '${modelu.image}',
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
                            '${modelu.name}',
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
                              '${SocialCubit.get(context).likeUser[index]}',
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
                          SocialCubit.get(context).postUserId[index],
                          modelu.uId);
                      SocialCubit.get(context).getLikes(
                          SocialCubit.get(context).postUserId[index],
                          index,
                          modelu.uId);
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
