part of '../log_in_page.dart';

class _LogInPageLoginButtonWidget extends StatelessWidget {
  const _LogInPageLoginButtonWidget({
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
    return BlocBuilder<LogInPageCubit, LogInPageState>(
      builder: (context, state) {
        return AppButtons.filledButton(
          child: state is LogInPageLoadingState
              ? SizedBox(
                  width: 26.h,
                  height: 26.h,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  'Log in',
                  style: AppTextStyles.bold(
                    fontSize: 18.sp,
                    color: Colors.white,
                  ),
                ),
          onTap: state is LogInPageLoadingState
              ? null
              : () => context.read<LogInPageCubit>().onTapLogIn(
                    email: _emailInputController.text.trim(),
                    password: _passwordInputController.text.trim(),
                  ),
          color: Colors.black,
        );
      },
    );
  }
}
