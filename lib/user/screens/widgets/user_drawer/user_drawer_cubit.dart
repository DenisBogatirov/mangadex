// Dart imports:
import 'dart:async';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/auth/domain/use_cases/sign_out.use_case.dart';
import 'package:mangadex/auth/domain/use_cases/subscribe_to_sign_out.use_case.dart';
import 'package:mangadex/user/domain/use_cases/get_current_user.use_case.dart';
import 'package:mangadex/user/domain/user.dart';

part 'user_drawer_state.dart';

@Injectable()
class UserDrawerCubit extends Cubit<UserDrawerState> {
  final GetCurrentUserUseCase _currentUserUseCase;
  final SignOutUseCase _signOutUseCase;
  final SubscribeToSignOutUseCase _subscribeToSignOutUseCase;
  late final StreamSubscription<void> _signOutSubscription;

  UserDrawerCubit(
    this._currentUserUseCase,
    this._signOutUseCase,
    this._subscribeToSignOutUseCase,
  ) : super(UserDrawerInitial()) {
    fetchCurrentUser();
    _signOutSubscription = _subscribeToSignOutUseCase(_onSignOut);
  }

  Future<void> fetchCurrentUser() async {
    final user = await _currentUserUseCase();
    emit(UserDrawerReady(user));
  }

  Future<void> signOut() async {
    await _signOutUseCase();
  }

  void _onSignOut(_) {
    emit(UserDrawerReady(GuestUser()));
  }

  @override
  Future<void> close() async {
    await _signOutSubscription.cancel();
    return super.close();
  }
}
