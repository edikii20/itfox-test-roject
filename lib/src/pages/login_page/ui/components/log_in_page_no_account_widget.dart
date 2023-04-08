part of '../log_in_page.dart';

class _LogInPageNoAccountWidget extends StatelessWidget {
  const _LogInPageNoAccountWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'No account? ',
          style: AppTextStyles.semiBold(
            fontSize: 16.sp,
            color: Colors.grey.shade700,
          ),
        ),
        InkWell(
          onTap: () => context.goNamed('signup'),
          child: Text(
            'Create one',
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
