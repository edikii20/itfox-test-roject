part of '../sign_up_page.dart';

class _SignUpPagePasswordInputWidget extends StatelessWidget {
  const _SignUpPagePasswordInputWidget({
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
    return BlocBuilder<SignUpPageCubit, SignUpPageState>(
      buildWhen: (previous, current) =>
          (current is SignUpPageFailureState &&
              current.errorType == AuthenticationErrorType.incorrectPassword) ||
          (current is! SignUpPageFailureState &&
              previous is SignUpPageFailureState &&
              previous.errorType == AuthenticationErrorType.incorrectPassword),
      builder: (context, state) {
        return AuthenticationInputWidget(
          controller: _passwordInputController,
          hintText: 'Password',
          currentFocusNode: _passwordInputFocusNode,
          error: state is SignUpPageFailureState ? state.message : null,
        );
      },
    );
  }
}
