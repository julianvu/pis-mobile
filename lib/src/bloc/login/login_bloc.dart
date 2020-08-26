import 'package:bloc/bloc.dart';
import 'package:pis_mobile/repository/auth.dart';
import 'package:pis_mobile/src/bloc/login/login_event.dart';
import 'package:pis_mobile/src/bloc/login/login_state.dart';
import 'package:pis_mobile/src/bloc/validators.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepo _authRepo;

  LoginBloc({AuthRepo authRepo})
      : _authRepo = authRepo,
        super(LoginState.initial());

  Stream<LoginState> _mapLoginEmailChangedToState(String email) async* {
    yield state.update(isEmailValid: Validators.validateEmail(email));
  }

  Stream<LoginState> _mapLoginPasswordChangedToState(String password) async* {
    yield state.update(isPasswordValid: Validators.validatePassword(password));
  }

  Stream<LoginState> _mapLoginWithEmailAndPasswordPressedToState(
      {String email, String password}) async* {
    yield LoginState.loading();
    try {
      await _authRepo.signInWithEmailAndPassword(email, password);
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginEmailChanged) {
      yield* _mapLoginEmailChangedToState(event.email);
    } else if (event is LoginPasswordChanged) {
      yield* _mapLoginPasswordChangedToState(event.password);
    } else if (event is LoginWithEmailAndPasswordPressed) {
      yield* _mapLoginWithEmailAndPasswordPressedToState(
          email: event.email, password: event.password);
    }
  }
}
