import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_to_speech/src/login/events/login_event.dart';
import 'package:text_to_speech/src/login/repository.dart';
import 'package:text_to_speech/src/login/states/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc(this.authRepository) : super(LoginState.initial()) {
    on<EmailChanged>(((event, emit) {
      emit(state.copyWith(email: event.email));
    }));
    on<PasswordChanged>(((event, emit) {
      emit(state.copyWith(password: event.password));
    }));
    on<Submitted>(((event, emit) async {
      emit(state.copyWith(isSubmitting: true, isFailure: false, isSuccess: false));
      try {
        final data = await authRepository.register(state.email, state.password);
        print(data);
        if (data.user != null) {
          emit(state.copyWith(isSubmitting: false, isSuccess: true));
        } else {
          emit(state.copyWith(isSubmitting: false, isFailure: true, errorMessage: '${data}')); //-
        }
      } catch (_) {
        emit(state.copyWith(isSubmitting: false, isFailure: true));
        
      }
      
    }));
  }
}
