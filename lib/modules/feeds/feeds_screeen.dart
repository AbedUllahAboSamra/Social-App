import 'package:app_social/layout/social/cubit/cubit.dart';
import 'package:app_social/layout/social/cubit/states.dart';
import 'package:app_social/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/Post_model/post_model.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Builder(builder: (context) {
      //SocialCubit.get(context).getPostAll();
      return BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          if (SocialCubit.get(context).postModels.length > 0 &&
              SocialCubit.get(context).usermodel != null)
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 10.0,
                    margin: EdgeInsets.all(
                      8.0,
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Image(
                          image: NetworkImage(
                            'https://img.freepik.com/free-photo/two-beautiful-little-girls-walk-botanical-garden-surrounded-by-tropical-leaves-keep-secrets_98296-6641.jpg',
                          ),
                          fit: BoxFit.cover,
                          height: size.height * 0.21,
                          width: double.infinity,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'communicate with friends',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                height: 1.0,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => buildPostItem(
                        context,
                        size,
                        cubit.postModels[index],
                        cubit.usermodel!.image,
                        index,
                        state),
                    itemCount: cubit.postModels.length,
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
            );
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: size.height * 0.2,
                ),
                Text(
                  'Please check the network',
                  style: TextStyle(fontSize: 25),
                ),
              ],
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
                      '${model.image}',
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
                            '${model.name}',
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
              // Padding(
              //   padding: const EdgeInsets.only(
              //     bottom: 8.0,
              //     top: 3.0,
              //   ),
              //   child: Container(
              //     width: double.infinity,
              //     child: Wrap(
              //       crossAxisAlignment: WrapCrossAlignment.start,
              //       children: [
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 2.0),
              //           child: Container(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               minWidth: 1.0, //باخد حجم الخط بس
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                 '#Ahmed',
              //                 style: TextStyle(color: Colors.blue),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 2.0),
              //           child: Container(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               minWidth: 1.0, //باخد حجم الخط بس
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                 '#Ahmed',
              //                 style: TextStyle(color: Colors.blue),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 2.0),
              //           child: Container(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               minWidth: 1.0, //باخد حجم الخط بس
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                 '#Ahmed',
              //                 style: TextStyle(color: Colors.blue),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 2.0),
              //           child: Container(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               minWidth: 1.0, //باخد حجم الخط بس
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                 '#Ahmed',
              //                 style: TextStyle(color: Colors.blue),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 2.0),
              //           child: Container(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               minWidth: 1.0, //باخد حجم الخط بس
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                 '#Ahmed',
              //                 style: TextStyle(color: Colors.blue),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 2.0),
              //           child: Container(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               minWidth: 1.0, //باخد حجم الخط بس
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                 '#Ahmed',
              //                 style: TextStyle(color: Colors.blue),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 2.0),
              //           child: Container(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               minWidth: 1.0, //باخد حجم الخط بس
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                 '#Ahmed',
              //                 style: TextStyle(color: Colors.blue),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 2.0),
              //           child: Container(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               minWidth: 1.0, //باخد حجم الخط بس
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                 '#Ahmed',
              //                 style: TextStyle(color: Colors.blue),
              //               ),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsetsDirectional.only(end: 2.0),
              //           child: Container(
              //             height: 25.0,
              //             child: MaterialButton(
              //               onPressed: () {},
              //               minWidth: 1.0, //باخد حجم الخط بس
              //               padding: EdgeInsets.zero,
              //               child: Text(
              //                 '#Ahmed',
              //                 style: TextStyle(color: Colors.blue),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
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
                              '${SocialCubit.get(context).Likes[index]}',
                              //'',

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
                      SocialCubit.get(context)
                          .likePost(SocialCubit.get(context).postsId[index],model.uId);
                      SocialCubit.get(context).getLikes(
                          SocialCubit.get(context).postsId[index], index,model.uId);
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
