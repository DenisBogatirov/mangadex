// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/auth/domain/use_cases/sign_out.use_case.dart';
import 'package:mangadex/infrastructure/router/router.dart';
import 'package:mangadex/infrastructure/router/router.gr.dart';
import 'package:mangadex/user/domain/use_cases/get_current_user.use_case.dart';
import 'package:mangadex/user/domain/user.dart';

part 'user_drawer_state.dart';

@Injectable()
class UserDrawerCubit extends Cubit<UserDrawerState> {
  final GetCurrentUserUseCase _currentUserUseCase;
  final SignOutUseCase _signOutUseCase;
  final AppRouter _router;

  UserDrawerCubit(
    this._currentUserUseCase,
    this._signOutUseCase,
    this._router,
  ) : super(UserDrawerInitial()) {
    fetchCurrentUser();
  }

  Future<void> fetchCurrentUser() async {
    final user = await _currentUserUseCase();
    emit(UserDrawerReady(user));
  }

  Future<void> signOut() async {
    await _signOutUseCase();
    _router.replaceAll([const SignInRoute()]);
  }
}
