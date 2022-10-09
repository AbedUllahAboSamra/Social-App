import 'package:app_social/layout/social/cubit/cubit.dart';
import 'package:app_social/layout/social/cubit/states.dart';
import 'package:app_social/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/Social_model/scoial_user_model.dart';

class NewPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        var formKey = GlobalKey<FormState>();
        Size size = MediaQuery.of(context).size;
        var usermodel = SocialCubit.get(context).usermodel;
        var text = SocialCubit.get(context).text;
        var now = DateTime.now();
        // if (SocialCubit.get(context).text != null) {
        //   //textController.text = SocialCubit.get(context).text!;
        // }
        return Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                  padding: const EdgeInsetsDirectional.only(
                      bottom: 10, top: 10.0, end: 15.0),
                  child: post(text, context, now)),
            ],
            title: Text('Add Post'),
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
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
                child: body(state, usermodel!, size, context, now)),
          ),
        );
      },
    );
  }

  ImageProvider<Object> imageFill({required Image, required ImageModel}) {
    if (Image == null) return NetworkImage('${ImageModel}');
    return FileImage(Image);
  }

  Widget body(state, SocialUserModel usermodel, Size size, context, now) {
    print(SocialCubit.get(context).posts == []);
    if (SocialCubit.get(context).usermodel != null)
      return Column(
        children: [
          if (state is SocialCratePostLoadingState) LinearProgressIndicator(),
          if (state is SocialCratePostLoadingState)
            SizedBox(
              height: 15.0,
            ),
          Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                  '${usermodel.image}',
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
                        '${usermodel.name}',
                        style: TextStyle(
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${now.toString()}',
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(height: 1.3),
                  ),
                ],
              ),
            ],
          ),
          TextFormField(
            maxLength: 250,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'What is on your mind ...',
              border: InputBorder.none,
            ),
            onChanged: (String s) {
              SocialCubit.get(context).string(s);
            },
          ),
          if (SocialCubit.get(context).postImage != null)
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Container(
                  height: size.height * 0.4,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    image: DecorationImage(
                      image: FileImage(SocialCubit.get(context).postImage!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    SocialCubit.get(context).removePostImage();
                  },
                  icon: CircleAvatar(
                    radius: 20.0,
                    child: Icon(
                      IconBroken.Close_Square,
                      size: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          Row(
            children: [
              Expanded(
                child: TextButton(
                    onPressed: () {
                      SocialCubit.get(context).getPostImage();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          IconBroken.Image,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('add photo'),
                      ],
                    )),
              ),
              SizedBox(
                width: size.width * 0.2,
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    '# tags',
                  ),
                ),
              ),
            ],
          )
        ],
      );
    return Column(
      children: [
        if (state is SocialCratePostLoadingState) LinearProgressIndicator(),
        if (state is SocialCratePostLoadingState)
          SizedBox(
            height: 15.0,
          ),
        Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(
                '',
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
                      '',
                      style: TextStyle(
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${now.toString()}',
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(height: 1.3),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: size.height * .2,
        ),
        Center(
            child: Text(
          'Please check the network',
          style: TextStyle(fontSize: 25),
        )),
        SizedBox(
          height: size.height * .1,
        ),
        if (SocialCubit.get(context).postImage != null)
          Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Container(
                height: size.height * 0.4,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  image: DecorationImage(
                    image: FileImage(SocialCubit.get(context).postImage!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  SocialCubit.get(context).removePostImage();
                },
                icon: CircleAvatar(
                  radius: 20.0,
                  child: Icon(
                    IconBroken.Close_Square,
                    size: 16.0,
                  ),
                ),
              ),
            ],
          ),
        Row(
          children: [
            Expanded(
              child: TextButton(
                  onPressed: () {
                    SocialCubit.get(context).getPostImage();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        IconBroken.Image,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('add photo'),
                    ],
                  )),
            ),
            SizedBox(
              width: size.width * 0.2,
            ),
            Expanded(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  '# tags',
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget post(text, context, now) {
    if ((text == null || text == '') &&
            SocialCubit.get(context).postImage == null ||
        SocialCubit.get(context).usermodel == null)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'POST',
            style: TextStyle(
              color: Color.fromARGB(255, 154, 145, 164),
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    return InkWell(
      onTap: () {
        //if (formKey.currentState!.validate()) {
        if (SocialCubit.get(context).postImage == null) {
          SocialCubit.get(context).cPost(dataTime: now.toString(), text: text);
          Navigator.pop(context);
          SocialCubit.get(context).text = '';
          SocialCubit.get(context).postImage = null;
          SocialCubit.get(context).currenIndex = 0;
        } else {
          SocialCubit.get(context)
              .createNewPost(dataTime: now.toString(), text: text);

          Navigator.pop(context);
          SocialCubit.get(context).text = '';
          SocialCubit.get(context).postImage = null;
          SocialCubit.get(context).currenIndex = 0;
        }
        //}
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'POST',
            style: TextStyle(
              color: Color.fromARGB(255, 119, 81, 163),
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
