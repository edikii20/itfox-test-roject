part of '../sign_up_page.dart';

class _SignUpPageHaveAccountWidget extends StatelessWidget {
  const _SignUpPageHaveAccountWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: AppTextStyles.semiBold(
            fontSize: 16.sp,
            color: Colors.grey.shade700,
          ),
        ),
        InkWell(
          onTap: () => context.goNamed('login'),
          child: Text(
            'Log in',
            style: AppTextStyles.semiBold(
              fontSize: 16.sp,
              color: Colors.deepPurple,
            ),
          ),
        ),
      ],
    );
  }
}
