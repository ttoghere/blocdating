// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sign_up_cubit.dart';

enum SignUpStatus { initial, submitting, success, error }

class SignupState extends Equatable {
  final String email;
  final String password;
  final SignUpStatus status;

  bool get isFormValid => email.isNotEmpty && password.isNotEmpty;

  const SignupState({
    required this.email,
    required this.password,
    required this.status,
  });

  factory SignupState.initial() {
    return SignupState(
      email: '',
      password: '',
      status: SignUpStatus.initial,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [email, password, status];

  SignupState copyWith({
    String? email,
    String? password,
    SignUpStatus? status,
  }) {
    return SignupState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}
