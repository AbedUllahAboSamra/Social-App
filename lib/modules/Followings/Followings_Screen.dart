import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/social/cubit/cubit.dart';
import '../../layout/social/cubit/states.dart';
import '../../models/Social_model/scoial_user_model.dart';
import '../../shared/components/compoents.dart';
import '../../shared/styles/style.dart';
import '../users/user_screen.dart';

class FollowingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        List<SocialUserModel> users = SocialCubit.get(context).users;
        if (users.length > 0)
          return ListView.separated(
            itemBuilder: (context, indxt) =>
                buildChatItem(size, users[indxt], context),
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              height: 10.0,
            ),
            itemCount: users.length,
          );
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget buildChatItem(size, SocialUserModel users, context) {
    return InkWell(
      onTap: () {
        navigateTo(context, widget: UserScreen(modelu: users));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(
                '${users.image}',
              ),
            ),
            SizedBox(
              width: size.width * 0.04,
            ),
            Text('${users.name}', style: black18()),
            Spacer(),
            follower(size, context),
          ],
        ),
      ),
    );
  }

  Widget follower(Size size, context) {
    if (5 == 5)
      return Container(
        height: size.height * 0.05,
        width: size.width * 0.33,
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
      width: size.width * 0.33,
      child: OutlinedButton(
        onPressed: () {
          //SocialCubit.get(context).getFollowres();
        },
        child: Text('Follower'),
      ),
    );
  }
}