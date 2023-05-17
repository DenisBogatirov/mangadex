part of 'user_drawer_cubit.dart';

abstract class UserDrawerState extends Equatable {
  const UserDrawerState();
}

class UserDrawerInitial extends UserDrawerState {
  @override
  List<Object> get props => [];
}

class UserDrawerReady extends UserDrawerState {
  final User user;

  const UserDrawerReady(this.user);

  @override
  List<Object> get props => [user];
}
