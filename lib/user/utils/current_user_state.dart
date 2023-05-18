part of 'current_user_cubit.dart';

sealed class CurrentUserState extends Equatable {
  const CurrentUserState();
}

class CurrentUserLoading extends CurrentUserState {
  @override
  List<Object> get props => [];
}

class CurrentUserReady extends CurrentUserState {
  final User user;

  const CurrentUserReady(this.user);

  bool get isGuest => user is GuestUser;

  @override
  List<Object> get props => [user];
}
