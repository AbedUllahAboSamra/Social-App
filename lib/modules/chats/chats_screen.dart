import 'package:app_social/modules/chats/chats_user_screen.dart';
import 'package:app_social/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/social/cubit/cubit.dart';
import '../../layout/social/cubit/states.dart';
import '../../models/Social_model/scoial_user_model.dart';
import '../../shared/components/compoents.dart';
import '../../shared/styles/style.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        List<SocialUserModel> users = SocialCubit.get(context).users;
        if (users.length > 0)
          return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, indxt) =>
                buildChatItem(size, users[indxt], context),
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              height: 10,
            ),
            itemCount: users.length,
          );
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget buildChatItem(
    size,
    SocialUserModel user,
    context,
  ) {
    return InkWell(
      onTap: () {
        navigateTo(
          context,
          widget: ChatUserScreen(userModel: user),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 27.0,
              backgroundImage: NetworkImage(
                '${user.image}',
              ),
            ),
            SizedBox(
              width: size.width * 0.04,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${user.name}', style: black18()),
                SizedBox(
                  height: 2,
                ),
                Text('${user.name}',
                    style: Theme.of(context).textTheme.caption),
              ],
            ),
            Spacer(),
            InkWell(
              splashColor: Colors.white,
              onTap: () {},
              child: CircleAvatar(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                radius: 25.0,
                child: Icon(IconBroken.Camera, size: 30.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
