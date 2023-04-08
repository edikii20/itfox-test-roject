import 'dart:math';
import 'package:itfox_test_project/src/domain/db/hive_db/box_manager.dart';
import 'package:itfox_test_project/src/domain/entities/user.dart';

enum AuthenticationInputValidationType { email, password }

enum AuthenticationErrorType {
  incorrectEmail,
  incorrectPassword,
  emailAlreadyInUse,
  userNotFound,
  unknownError,
}

class SignUpFailure implements Exception {
  final String message;
  final AuthenticationErrorType errorType;
  const SignUpFailure({
    this.message = 'An unknown exception occurred.',
    this.errorType = AuthenticationErrorType.unknownError,
  });

  factory SignUpFailure.fromCode(String code) {
    switch (code) {
      case 'incorrect-email':
        return const SignUpFailure(
          message: 'Email is not valid or badly formatted.',
          errorType: AuthenticationErrorType.incorrectEmail,
        );
      case 'email-already-in-use':
        return const SignUpFailure(
          message: 'An account already exists for that email.',
          errorType: AuthenticationErrorType.emailAlreadyInUse,
        );
      case 'incorrect-password':
        return const SignUpFailure(
          message: 'Password is not valid or badly formatted.',
          errorType: AuthenticationErrorType.incorrectPassword,
        );
      default:
        return const SignUpFailure();
    }
  }
}

class LogInFailure implements Exception {
  final String message;
  final AuthenticationErrorType errorType;
  const LogInFailure({
    this.message = 'An unknown exception occurred.',
    this.errorType = AuthenticationErrorType.unknownError,
  });

  factory LogInFailure.fromCode(String code) {
    switch (code) {
      case 'incorrect-email':
        return const LogInFailure(
          message: 'Email is not valid or badly formatted.',
          errorType: AuthenticationErrorType.incorrectEmail,
        );
      case 'user-not-found':
        return const LogInFailure(
          message: 'Email is not found, please create an account.',
          errorType: AuthenticationErrorType.userNotFound,
        );
      case 'incorrect-password':
        return const LogInFailure(
          message: 'Incorrect password, please try again.',
          errorType: AuthenticationErrorType.incorrectPassword,
        );
      default:
        return const LogInFailure();
    }
  }
}

class AuthenticationRepository {
  final _emailValidator = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  final _passwordValidator =
      RegExp(r"^[a-zA-Z0-9!#\$%&'\(\)\*\+,-\.\/:;<=>\?@[\]\^_`\{\|}~]{8,30}$");

  AuthenticationRepository();

  bool _validate({
    required AuthenticationInputValidationType inputType,
    required String text,
  }) {
    switch (inputType) {
      case AuthenticationInputValidationType.email:
        return _emailValidator.hasMatch(text);
      case AuthenticationInputValidationType.password:
        return _passwordValidator.hasMatch(text);
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    if (_validate(
      inputType: AuthenticationInputValidationType.email,
      text: email,
    )) {
      if (!_validate(
        inputType: AuthenticationInputValidationType.password,
        text: password,
      )) {
        throw SignUpFailure.fromCode('incorrect-password');
      }
    } else {
      throw SignUpFailure.fromCode('incorrect-email');
    }
    final usersBox = await BoxManager.instance.openUsersBox();
    if (!usersBox.values.any((user) => user.email == email)) {
      await usersBox.add(User(
        email: email,
        password: password,
      ));
      await BoxManager.instance.closeBox(usersBox);
    } else {
      await BoxManager.instance.closeBox(usersBox);
      throw SignUpFailure.fromCode('email-already-in-use');
    }
  }

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    if (_validate(
      inputType: AuthenticationInputValidationType.email,
      text: email,
    )) {
      if (!_validate(
        inputType: AuthenticationInputValidationType.password,
        text: password,
      )) {
        throw LogInFailure.fromCode('incorrect-password');
      }
    } else {
      throw LogInFailure.fromCode('incorrect-email');
    }
    final usersBox = await BoxManager.instance.openUsersBox();

    final user = usersBox.values.firstWhere(
      (user) => user.email == email,
      orElse: () => throw LogInFailure.fromCode('user-not-found'),
    );

    if (user.password == password) {
      final sessionBox = await BoxManager.instance.openSessionsBox();
      await sessionBox.put(
        'session',
        '${Random().nextInt(1000000000) + 1000000000}',
      );
      await BoxManager.instance.closeBox(sessionBox);
      await BoxManager.instance.closeBox(usersBox);
    } else {
      await BoxManager.instance.closeBox(usersBox);
      throw LogInFailure.fromCode('incorrect-password');
    }
  }

  Future<String?> getSession() async {
    final sessionsBox = await BoxManager.instance.openSessionsBox();
    final session = sessionsBox.get('session');
    await BoxManager.instance.closeBox(sessionsBox);
    return session;
  }

  Future<void> logOut() async {
    final sessionsBox = await BoxManager.instance.openSessionsBox();
    await sessionsBox.delete('session');
    await BoxManager.instance.closeBox(sessionsBox);
  }
}
