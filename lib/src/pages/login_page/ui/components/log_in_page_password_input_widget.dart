part of '../log_in_page.dart';

class _LogInPagePasswordInputWidget extends StatelessWidget {
  const _LogInPagePasswordInputWidget({
    Key? key,
    required TextEditingController passwordInputController,
    required FocusNode passwordInputFocusNode,
  })  : _passwordInputFocusNode = passwordInputFocusNode,
        _passwordInputController = passwordInputController,
        super(key: key);

  final TextEditingController _passwordInputController;
  final FocusNode _passwordInputFocusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogInPageCubit, LogInPageState>(
      buildWhen: (previous, current) =>
          (current is LogInPageFailureState &&
              current.errorType == AuthenticationErrorType.incorrectPassword) ||
          (current is! LogInPageFailureState &&
              previous is LogInPageFailureState &&
              previous.errorType == AuthenticationErrorType.incorrectPassword),
      builder: (context, state) {
        return AuthenticationInputWidget(
          controller: _passwordInputController,
          hintText: 'Password',
          currentFocusNode: _passwordInputFocusNode,
          error: state is LogInPageFailureState ? state.message : null,
        );
      },
    );
  }
}
