import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:itfox_test_project/src/domain/repositories/authentication_repository.dart';
import 'package:itfox_test_project/src/pages/signup_page/cubit/sign_up_page_cubit.dart';
import '../../../config/app_text_styles.dart';
import '../../../utils/app_buttons.dart';
import '../../../utils/authentication_input_widget.dart';

part 'components/sign_up_page_create_account_button_widget.dart';
part 'components/sign_up_page_email_input_widget.dart';
part 'components/sign_up_page_password_input_widget.dart';
part 'components/sign_up_page_have_account_widget.dart';

class SignUpPageWidget extends StatefulWidget {
  const SignUpPageWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpPageWidget> createState() => _SignUpPageWidgetState();
}

class _SignUpPageWidgetState extends State<SignUpPageWidget> {
  late final TextEditingController _emailInputController;
  late final TextEditingController _passwordInputController;
  late final FocusNode _passwordInputFocusNode;

  @override
  void initState() {
    super.initState();
    _emailInputController = TextEditingController();
    _passwordInputController = TextEditingController();
    _passwordInputFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailInputController.dispose();
    _passwordInputController.dispose();
    _passwordInputFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpPageCubit, SignUpPageState>(
      listenWhen: (previous, current) => current is SignUpPageCompleteState,
      listener: (context, state) {
        context.goNamed('login');
      },
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Text(
                    'Sign up',
                    style: AppTextStyles.bold(
                      fontSize: 32.sp,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  _SignUpPageEmailInputWidget(
                    emailInputController: _emailInputController,
                    passwordInputFocusNode: _passwordInputFocusNode,
                  ),
                  SizedBox(height: 20.h),
                  _SignUpPagePasswordInputWidget(
                    passwordInputController: _passwordInputController,
                    passwordInputFocusNode: _passwordInputFocusNode,
                  ),
                  SizedBox(height: 30.h),
                  _SignUpPageCreateAccountButtonWidget(
                    emailInputController: _emailInputController,
                    passwordInputController: _passwordInputController,
                  ),
                  SizedBox(height: 20.h),
                  const _SignUpPageHaveAccountWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
