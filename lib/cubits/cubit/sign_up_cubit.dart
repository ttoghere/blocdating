import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blocdating/repositories/auth/auth_repository.dart';
import 'package:blocdating/screens/onboarding/onboarding_screens/screens.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'sign_up_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository _authRepository;

  SignupCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(SignupState.initial());

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: SignUpStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: SignUpStatus.initial));
  }

  Future<void> signUpWithCredentials(BuildContext context) async {
    if (!state.isFormValid || state.status == SignUpStatus.submitting) return;
    emit(
      state.copyWith(status: SignUpStatus.submitting),
    );
    try {
      if (state.email.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                "Fill the Email area with\nvalid email for verification.")));
      } else if (state.password.isEmpty || state.password.length <= 6) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                "Fill the Password area with\na password what greater count then 6 as characters")));
      } else {
        var user = await _authRepository.signUp(
            email: state.email, password: state.password);
        emit(
          state.copyWith(
            status: SignUpStatus.success,
            user: user,
          ),
        );
      }
    } catch (_) {}
  }
}