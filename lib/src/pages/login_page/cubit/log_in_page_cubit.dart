import 'package:bloc/bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../../../domain/repositories/authentication_repository.dart';

part 'log_in_page_state.dart';

class LogInPageCubit extends Cubit<LogInPageState> {
  final AuthenticationRepository _authenticationRepository;
  LogInPageCubit({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(LogInPageInitialState()) {
    FlutterNativeSplash.remove();
  }

  Future<void> onTapLogIn({
    required String email,
    required String password,
  }) async {
    emit(LogInPageLoadingState());
    try {
      await _authenticationRepository.logIn(
        email: email,
        password: password,
      );
      emit(LogInPageCompleteState());
    } on LogInFailure catch (e) {
      emit(LogInPageFailureState(
        message: e.message,
        errorType: e.errorType,
      ));
    }
  }
}
