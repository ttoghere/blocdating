// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sign_up_cubit.dart';

enum SignUpStatus { initial, submitting, success, error }

class SignupState extends Equatable {
  final String email;
  final String password;
  final SignUpStatus status;
  final User? user;

  bool get isFormValid => email.isNotEmpty && password.isNotEmpty;

  const SignupState({
    this.user,
    required this.email,
    required this.password,
    required this.status,
  });

  factory SignupState.initial() {
    return const SignupState(
      email: '',
      password: '',
      status: SignUpStatus.initial,
      user: null,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [email, password, status, user];

  SignupState copyWith({
    String? email,
    String? password,
    SignUpStatus? status,
    User? user,
  }) {
    return SignupState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }
}
