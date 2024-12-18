import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_to_speech/src/login/events/login_event.dart';
import 'package:text_to_speech/src/login/states/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on<EmailChanged>(((event, emit) {
      emit(state.copyWith(email: event.email));
    }));
    on<PasswordChanged>(((event, emit) {
      emit(state.copyWith(password: event.password));
    }));
    on<Submitted>(((event, emit) async {
      emit(state.copyWith(
          isSubmitting: true, isFailure: false, isSuccess: false));
      try {
        // Fake API call delay
        await Future.delayed(const Duration(seconds: 2));

        if (state.email == "user@example.com" && state.password == "password") {
          emit(state.copyWith(isSubmitting: false, isSuccess: true));
          print("Đăng nhập thành công");
        } else {
          emit(state.copyWith(isSubmitting: false, isFailure: true));
        }
      } catch (_) {
        emit(state.copyWith(isSubmitting: false, isFailure: true));
      }
    }));
  }
}
