abstract class SocialState {}

class SocialInitialState extends SocialState {}

class SocialGetUserLoadingState extends SocialState {}

class SocialGetUserSuccessState extends SocialState {}

class SocialGetUserErrorState extends SocialState {
  final String error;

  SocialGetUserErrorState(this.error);
}

class SocialChangeBottomNavState extends SocialState {}

class SocialChangeBottomUsersState extends SocialState {}

class SocialChangeFollowerScerrnState extends SocialState {}

class SocialNewPostState extends SocialState {}

class SocialFollowresLiognState extends SocialState {}

class SocialFollowresSuccessState extends SocialState {}

class SocialFollowresErrorState extends SocialState {}

class SocialFollowingsSuccessState extends SocialState {}

class SocialFollowingsErrorState extends SocialState {}

class SocialProfileImagePickedSuccessState extends SocialState {}

class SocialProfileImagePickedErrorState extends SocialState {}

class SocialImageMessagePickedSuccessState extends SocialState {}

class SocialImageMessagePickedErrorState extends SocialState {}

class SocialCoverImagePickedSuccessState extends SocialState {}

class SocialCoverImagePickedErrorState extends SocialState {}

class SocialUoloadProfileSuccessState extends SocialState {}

class SocialUoloadProfileErrorState extends SocialState {}

class SocialUoloadCoverSuccessState extends SocialState {}

class SocialUoloadCoverErrorState extends SocialState {}

class SocialUsersUpdataLoadingState extends SocialState {}

class SocialUsersUpdataErrorState extends SocialState {}

class SocialCratePostLoadingState extends SocialState {}

class SocialCratePostSuccessState extends SocialState {}


class SocialCratePostErrorState extends SocialState {}

class SocialPostImagePickedSuccessState extends SocialState {}

class SocialPostImagePickedErrorState extends SocialState {}

class SocialRemovePostImageState extends SocialState {}

class SocialStringState extends SocialState {}

class SocialGetPostLoadingState extends SocialState {}

class SocialGetPostSuccessState extends SocialState {}

class SocialGetPostmySuccessState extends SocialState {}


class SocialGetPostErrorState extends SocialState {}

class SocialGetUsersModeLoadingState extends SocialState {}

class SocialGetUsersModeSuccessState extends SocialState {}


class SocialGetUsersModeErrorState extends SocialState {}

class SocialGetLikesLoadingState extends SocialState {}

class SocialGetLikesSuccessState extends SocialState {}


class SocialGetLikesErrorState extends SocialState {}

class SocialGetMessageSuccessState extends SocialState {}


class SocialGetMessageErrorState extends SocialState {}

class SocialSendMessageSuccessState extends SocialState {}


class SocialSendMessageErrorState extends SocialState {}
