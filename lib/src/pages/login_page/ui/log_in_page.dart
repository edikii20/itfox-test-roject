import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:itfox_test_project/src/pages/login_page/cubit/log_in_page_cubit.dart';
import '../../../config/app_text_styles.dart';
import '../../../domain/repositories/authentication_repository.dart';
import '../../../utils/app_buttons.dart';
import '../../../utils/authentication_input_widget.dart';

part 'components/log_in_page_login_button_widget.dart';
part 'components/log_in_page_email_input_widget.dart';
part 'components/log_in_page_password_input_widget.dart';
part 'components/log_in_page_no_account_widget.dart';

class LogInPageWidget extends StatefulWidget {
  const LogInPageWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<LogInPageWidget> createState() => _LogInPageWidgetState();
}

class _LogInPageWidgetState extends State<LogInPageWidget> {
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
    return BlocListener<LogInPageCubit, LogInPageState>(
      listenWhen: (previous, current) => current is LogInPageCompleteState,
      listener: (context, state) {
        context.goNamed('weather');
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
                    'Log in',
                    style: AppTextStyles.bold(
                      fontSize: 32.sp,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  _LogInPageEmailInputWidget(
                    emailInputController: _emailInputController,
                    passwordInputFocusNode: _passwordInputFocusNode,
                  ),
                  SizedBox(height: 20.h),
                  _LogInPagePasswordInputWidget(
                    passwordInputController: _passwordInputController,
                    passwordInputFocusNode: _passwordInputFocusNode,
                  ),
                  SizedBox(height: 30.h),
                  _LogInPageLoginButtonWidget(
                    emailInputController: _emailInputController,
                    passwordInputController: _passwordInputController,
                  ),
                  SizedBox(height: 20.h),
                  const _LogInPageNoAccountWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
