// Dart imports:
import 'dart:async';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/auth/domain/use_cases/sign_out.use_case.dart';
import 'package:mangadex/auth/domain/use_cases/subscribe_to_sign_in.use_case.dart';
import 'package:mangadex/auth/domain/use_cases/subscribe_to_sign_out.use_case.dart';
import 'package:mangadex/user/domain/use_cases/get_current_user.use_case.dart';
import 'package:mangadex/user/domain/user.dart';

part 'current_user_state.dart';

@singleton
class CurrentUserCubit extends Cubit<CurrentUserState> {
  final GetCurrentUserUseCase _currentUserUseCase;
  final SignOutUseCase _signOutUseCase;
  final SubscribeToSignOutUseCase _subscribeToSignOutUseCase;
  final SubscribeToSignInUseCase _subscribeToSignInUseCase;
  late final StreamSubscription<void> _signOutSubscription;
  late final StreamSubscription<void> _signInSubscription;

  CurrentUserCubit(
    this._currentUserUseCase,
    this._signOutUseCase,
    this._subscribeToSignOutUseCase,
    this._subscribeToSignInUseCase,
  ) : super(CurrentUserLoading()) {
    _signOutSubscription = _subscribeToSignOutUseCase(_onSignOut);
    _signInSubscription = _subscribeToSignInUseCase(_onSignIn);
  }

  Future<void> fetchCurrentUser() async {
    final user = await _currentUserUseCase();
    emit(CurrentUserReady(user));
  }

  Future<void> signOut() async {
    await _signOutUseCase();
  }

  void _onSignOut(_) {
    emit(CurrentUserReady(GuestUser()));
  }

  void _onSignIn(_) {
    fetchCurrentUser();
  }

  @override
  Future<void> close() async {
    await _signOutSubscription.cancel();
    await _signInSubscription.cancel();
    return super.close();
  }
}
