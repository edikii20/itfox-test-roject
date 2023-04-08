import 'package:bloc/bloc.dart';
import '../../../domain/repositories/authentication_repository.dart';

part 'sign_up_page_state.dart';

class SignUpPageCubit extends Cubit<SignUpPageState> {
  final AuthenticationRepository _authenticationRepository;
  SignUpPageCubit({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(SignUpPageInitialState());

  Future<void> onTapCreateAccount({
    required String email,
    required String password,
  }) async {
    emit(SignUpPageLoadingState());
    try {
      await _authenticationRepository.signUp(
        email: email,
        password: password,
      );
      emit(SignUpPageCompleteState());
    } on SignUpFailure catch (e) {
      emit(SignUpPageFailureState(
        message: e.message,
        errorType: e.errorType,
      ));
    }
  }
}
