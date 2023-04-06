// Package imports:
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:mangadex/auth/domain/auth.dart';
import 'package:mangadex/auth/domain/use_cases/sign_in_with.use_case.dart';
import 'package:mangadex/infrastructure/router/router.dart';
import 'package:mangadex/infrastructure/router/router.gr.dart';

part 'sign_in_state.dart';

@Injectable()
class SignInCubit extends Cubit<SignInState> {
  final SignInWithUseCase _sIgnInWithUseCase;
  final AppRouter _router;

  SignInCubit(this._sIgnInWithUseCase, this._router) : super(SignInState.idle);

  Future<void> signIn(SignInPayload payload) async {
    try {
      emit(SignInState.loading);
      await _sIgnInWithUseCase(payload);
      _router.replaceAll([const HomeRoute()]);
    } catch(e) {
      rethrow;
    } finally {
      emit(SignInState.idle);
    }
  }
}
