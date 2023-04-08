import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/app_text_styles.dart';

class AuthenticationInputWidget extends StatelessWidget {
  const AuthenticationInputWidget({
    Key? key,
    required TextEditingController controller,
    required String hintText,
    required String? error,
    FocusNode? currentFocusNode,
    FocusNode? nextFocusNode,
  })  : _nextFocusNode = nextFocusNode,
        _currentFocusNode = currentFocusNode,
        _controller = controller,
        _hintText = hintText,
        _error = error,
        super(key: key);

  final TextEditingController _controller;
  final String _hintText;
  final String? _error;
  final FocusNode? _currentFocusNode;
  final FocusNode? _nextFocusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: _currentFocusNode,
      onSubmitted: (value) => _nextFocusNode?.requestFocus(),
      textInputAction:
          _nextFocusNode != null ? TextInputAction.next : TextInputAction.done,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        errorStyle: AppTextStyles.medium(
          fontSize: 12.sp,
          color: Colors.red.shade900,
        ),
        hintText: _hintText,
        errorText: _error,
      ),
      style: AppTextStyles.semiBold(
        fontSize: 18.sp,
        color: Colors.black,
      ),
    );
  }
}
