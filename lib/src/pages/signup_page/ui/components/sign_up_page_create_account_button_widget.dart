part of '../sign_up_page.dart';

class _SignUpPageCreateAccountButtonWidget extends StatelessWidget {
  const _SignUpPageCreateAccountButtonWidget({
    Key? key,
    required TextEditingController emailInputController,
    required TextEditingController passwordInputController,
  })  : _emailInputController = emailInputController,
        _passwordInputController = passwordInputController,
        super(key: key);

  final TextEditingController _emailInputController;
  final TextEditingController _passwordInputController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpPageCubit, SignUpPageState>(
      builder: (context, state) {
        return AppButtons.filledButton(
          child: state is SignUpPageLoadingState
              ? SizedBox(
                  width: 26.h,
                  height: 26.h,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  'Create account',
                  style: AppTextStyles.bold(
                    fontSize: 18.sp,
                    color: Colors.white,
                  ),
                ),
          onTap: state is SignUpPageLoadingState
              ? null
              : () => context.read<SignUpPageCubit>().onTapCreateAccount(
                    email: _emailInputController.text.trim(),
                    password: _passwordInputController.text.trim(),
                  ),
          color: Colors.black,
        );
      },
    );
  }
}
