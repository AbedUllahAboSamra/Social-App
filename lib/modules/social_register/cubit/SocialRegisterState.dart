abstract class SocialRegisterState {}

class SocialRegisterInitialState extends SocialRegisterState{}

class SocialRegisterLoadingState extends SocialRegisterState {}

class SocialRegisterSuccessState extends SocialRegisterState{
  dynamic uId;

  SocialRegisterSuccessState(this.uId);
}

class SocialRegisterErrorState extends SocialRegisterState{
  dynamic error;

  SocialRegisterErrorState(this.error);
}

class SocialCreateUserSuccessState extends SocialRegisterState{
  dynamic uId;

  SocialCreateUserSuccessState(this.uId);
}

class SocialCreateUseErrorState extends SocialRegisterState{
  final String error;

  SocialCreateUseErrorState(this.error);
}

class SocialRegisterChangePasswordVisibilityState extends SocialRegisterState{}