import 'package:app_social/models/Social_model/scoial_user_model.dart';
import 'package:app_social/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/social/cubit/cubit.dart';
import '../../layout/social/cubit/states.dart';
import '../../shared/styles/style.dart';

class ChatUserScreen extends StatelessWidget {
  SocialUserModel userModel;
  ChatUserScreen({required this.userModel});
  @override
  Widget build(BuildContext context) {
    var messgetext = TextEditingController();

    Size size = MediaQuery.of(context).size;
    return Builder(builder: (context) {
      SocialCubit.get(context).getMessages(receiverId: userModel.uId);
      messgetext.text = SocialCubit.get(context).Stringmessage;
      return BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  IconBroken.Arrow___Left_2,
                ),
              ),
              titleSpacing: 0.0,
              title: Row(
                children: [
                  SizedBox(
                    width: size.width * 0.01,
                  ),
                  CircleAvatar(
                    radius: 23.0,
                    backgroundImage: NetworkImage(
                      '${userModel.image}',
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.04,
                  ),
                  Text('${userModel.name}', style: black18()),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: [
                Expanded(
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (SocialCubit.get(context).usermodel!.uId ==
                          SocialCubit.get(context).messages[index].senderId)
                        return buildMyMessges(
                            size: size,
                            text:
                                SocialCubit.get(context).messages[index].text);
                      return buildSendMessges(
                          size: size,
                          text: SocialCubit.get(context).messages[index].text);
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: 5.0,
                    ),
                    itemCount: SocialCubit.get(context).messages.length,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(174, 212, 207, 207),
                              borderRadius: BorderRadius.circular(29),
                            ),
                            child: TextFormField(
                              controller: messgetext,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'tyoe your message here ...',
                              ),
                              onChanged: (s) {
                                SocialCubit.get(context).stringmessage(s);
                              },
                            ),
                          ),
                          if (SocialCubit.get(context).Stringmessage != '')
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: InkWell(
                                    onTap: () {
                                      SocialCubit.get(context).sendMessage(
                                        receiverId: userModel.uId,
                                        text: SocialCubit.get(context)
                                            .Stringmessage,
                                        dateTime: DateTime.now().toString(),
                                      );
                                      SocialCubit.get(context)
                                          .removeStringmessage();
                                      messgetext.text = '';
                                    },
                                    child: CircleAvatar(
                                      radius: 20.0,
                                      child: Icon(IconBroken.Send),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          else
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: InkWell(
                                    onTap: () {
                                      SocialCubit.get(context)
                                          .getImageMessage();
                                    },
                                    child: CircleAvatar(
                                      radius: 20.0,
                                      child: Icon(IconBroken.Image_2),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: InkWell(
                                    onTap: () {
                                      SocialCubit.get(context)
                                          .getCameraImageMessage();
                                    },
                                    child: CircleAvatar(
                                      radius: 20.0,
                                      child: Icon(IconBroken.Camera),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          );
        },
      );
    });
  }

  Widget buildSendMessges({required String text, required Size size}) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(end: 120.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
                topStart: Radius.circular(10.0),
              )),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Text(
              text,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMyMessges({required String text, required Size size}) {
    double a = size.width * .5;
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          start: 120,
        ),
        child: Container(
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 109, 167, 214),
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
                topStart: Radius.circular(10.0),
              )),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
