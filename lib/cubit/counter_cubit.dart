import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  // we need to set the initail state of the counter
  // which is CounterState()
  CounterCubit()
      : super(
          CounterState(
            counterValue: 0,
            wasIncremented: true,
          ),
        );

  // 'state' returns the instance of current state of our counter

  // increment, decrement functions
  void increment() => emit(
        CounterState(
          counterValue: state.counterValue + 1,
          wasIncremented: true,
        ),
      );

  void decrement() => emit(
        CounterState(
          counterValue: state.counterValue - 1,
          wasIncremented: false,
        ),
      );
}
