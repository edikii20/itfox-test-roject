part of '../log_in_page.dart';

class _LogInPageEmailInputWidget extends StatelessWidget {
  const _LogInPageEmailInputWidget({
    Key? key,
    required TextEditingController emailInputController,
    required FocusNode passwordInputFocusNode,
  })  : _passwordInputFocusNode = passwordInputFocusNode,
        _emailInputController = emailInputController,
        super(key: key);

  final TextEditingController _emailInputController;
  final FocusNode _passwordInputFocusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogInPageCubit, LogInPageState>(
      buildWhen: (previous, current) =>
          (current is LogInPageFailureState &&
              (current.errorType == AuthenticationErrorType.incorrectEmail ||
                  current.errorType == AuthenticationErrorType.userNotFound)) ||
          (current is! LogInPageFailureState &&
              previous is LogInPageFailureState &&
              (previous.errorType == AuthenticationErrorType.incorrectEmail ||
                  previous.errorType == AuthenticationErrorType.userNotFound)),
      builder: (context, state) {
        return AuthenticationInputWidget(
          controller: _emailInputController,
          hintText: 'Email',
          nextFocusNode: _passwordInputFocusNode,
          error: state is LogInPageFailureState ? state.message : null,
        );
      },
    );
  }
}
