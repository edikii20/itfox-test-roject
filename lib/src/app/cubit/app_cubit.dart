import 'package:bloc/bloc.dart';
import 'package:itfox_test_project/src/domain/repositories/authentication_repository.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final AuthenticationRepository _authenticationRepository;
  AppCubit({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(AppInitialState()) {
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    emit(await _authenticationRepository.getSession() != null
        ? AppAuthenticatedState()
        : AppUnAuthenticatedState());
  }

  Future<void> logOut() async {
    await _authenticationRepository.logOut();
    emit(AppUnAuthenticatedState());
  }
}
