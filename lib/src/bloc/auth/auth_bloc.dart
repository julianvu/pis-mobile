import 'package:bloc/bloc.dart';
import 'package:pis_mobile/models/user.dart';
import 'package:pis_mobile/repository/auth.dart';
import 'package:pis_mobile/src/bloc/auth/auth_event.dart';
import 'package:pis_mobile/src/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _authRepo;

  AuthBloc({AuthRepo authRepo})
      : _authRepo = authRepo,
        super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }

  // UserLoggedOut
  Stream<AuthState> _mapUserLoggedOutToState() async* {
    yield AuthNotAuthenticated();
    _authRepo.signOut();
  }

  // UserLoggedIn
  Stream<AuthState> _mapUserLoggedInToState() async* {
    yield AuthAuthenticated(user: await _authRepo.getCurrentUser());
  }

  // AppLoaded
  Stream<AuthState> _mapAppLoadedToState() async* {
    final isAuthenticated = await _authRepo.isAuthenticated();
    if (isAuthenticated) {
      final User user = await _authRepo.getCurrentUser();
      yield AuthAuthenticated(user: user);
    } else {
      yield AuthNotAuthenticated();
    }
  }
}
