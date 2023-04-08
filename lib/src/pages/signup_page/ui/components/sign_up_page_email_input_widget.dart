part of '../sign_up_page.dart';

class _SignUpPageEmailInputWidget extends StatelessWidget {
  const _SignUpPageEmailInputWidget({
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
    return BlocBuilder<SignUpPageCubit, SignUpPageState>(
      buildWhen: (previous, current) =>
          (current is SignUpPageFailureState &&
              (current.errorType == AuthenticationErrorType.incorrectEmail ||
                  current.errorType ==
                      AuthenticationErrorType.emailAlreadyInUse)) ||
          (current is! SignUpPageFailureState &&
              previous is SignUpPageFailureState &&
              (previous.errorType == AuthenticationErrorType.incorrectEmail ||
                  previous.errorType ==
                      AuthenticationErrorType.emailAlreadyInUse)),
      builder: (context, state) {
        return AuthenticationInputWidget(
          controller: _emailInputController,
          hintText: 'Email',
          nextFocusNode: _passwordInputFocusNode,
          error: state is SignUpPageFailureState ? state.message : null,
        );
      },
    );
  }
}
