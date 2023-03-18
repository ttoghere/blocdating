import 'package:blocdating/blocs/auth/auth_bloc.dart';
import 'package:blocdating/cubits/login/login_cubit.dart';
import 'package:blocdating/screens/screens.dart';
import 'package:blocdating/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login";
  const LoginScreen({super.key});
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) {
        return BlocProvider.of<AuthBloc>(context).state.status ==
                AuthStatus.authenticated
            ? const HomeScreen()
            : const LoginScreen();
      },
    );
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: CustomizedAppBar(
          title: "Login",
          hasActions: false,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'images/logo.svg',
              height: 100,
            ),
            const SizedBox(height: 20),
            Text(
              'ARROW',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            const EmailInput(),
            const SizedBox(height: 10),
            const PasswordInput(),
            const SizedBox(height: 10),
            CustomElevatedButton(
              text: 'LOGIN',
              textColor: Theme.of(context).primaryColor,
              onPressed: () {
                context.read<LoginCubit>().logInWithCredentials();
              },
              beginColor: Colors.white,
              endColor: Colors.white,
            ),
            const SizedBox(height: 10),
            CustomElevatedButton(
              text: 'SIGNUP',
              textColor: Colors.white,
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                OnboardingScreen.routeName,
                ModalRoute.withName('/onboarding'),
              ),
              beginColor: Theme.of(context).colorScheme.secondary,
              endColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          onChanged: (email) {
            context.read<LoginCubit>().emailChanged(email);
          },
          decoration: const InputDecoration(labelText: 'Email'),
        );
      },
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          onChanged: (password) {
            context.read<LoginCubit>().passwordChanged(password);
          },
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
        );
      },
    );
  }
}
