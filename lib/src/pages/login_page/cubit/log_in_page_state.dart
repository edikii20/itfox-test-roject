part of 'log_in_page_cubit.dart';

abstract class LogInPageState {}

class LogInPageCompleteState extends LogInPageState {}

class LogInPageInitialState extends LogInPageState {}

class LogInPageFailureState extends LogInPageState {
  final String message;
  final AuthenticationErrorType errorType;

  LogInPageFailureState({
    required this.message,
    required this.errorType,
  });
}

class LogInPageLoadingState extends LogInPageState {}
