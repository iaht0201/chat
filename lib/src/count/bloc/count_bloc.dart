import 'package:bloc/bloc.dart';
import 'package:text_to_speech/src/count/events/count_event.dart';
import 'package:text_to_speech/src/count/states/count_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState(0)) {
    on<IncrementEvent>((event, emit) {
      emit(CounterState(state.count + 1));
    });
    on<DecrementCountEvent>((event, emit) {
      emit(CounterState(state.count - 1));
    });
    on<ResetCountEvent>((event, emit) {
      emit(const CounterState(0));
    });
  }
}
