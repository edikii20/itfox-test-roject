part of 'sign_up_page_cubit.dart';

abstract class SignUpPageState {}

class SignUpPageCompleteState extends SignUpPageState {}

class SignUpPageInitialState extends SignUpPageState {}

class SignUpPageFailureState extends SignUpPageState {
  final String message;
  final AuthenticationErrorType errorType;

  SignUpPageFailureState({
    required this.message,
    required this.errorType,
  });
}

class SignUpPageLoadingState extends SignUpPageState {}
