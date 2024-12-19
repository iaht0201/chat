import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_to_speech/src/login/blog/login_bloc.dart';
import 'package:text_to_speech/src/login/events/login_event.dart';
import 'package:text_to_speech/src/login/repository.dart';
import 'package:text_to_speech/src/login/states/login_state.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(context.read<AuthRepository>()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Login")),
        body: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.isSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Login Successful!")),
              );
            } else if (state.isFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage ?? "Login Failed!")),
              );
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      onChanged: (value) {
                        context.read<LoginBloc>().add(LoginEvent.emailChanged(value));
                      },
                      decoration: InputDecoration(
                        labelText: "Email",
                        errorText: state.email.isEmpty ? "Email is required" : null,
                      ),
                    ),
                    TextField(
                      obscureText: true,
                      onChanged: (value) {
                        context.read<LoginBloc>().add(LoginEvent.passwordChanged(value));
                      },
                      decoration: InputDecoration(
                        labelText: "Password",
                        errorText: state.password.isEmpty ? "Password is required" : null,
                      ),
                    ),
                    const SizedBox(height: 16),
                    state.isSubmitting
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              context.read<LoginBloc>().add(const LoginEvent.submitted());
                            },
                            child: const Text("Login"),
                          ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
