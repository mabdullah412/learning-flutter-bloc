import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  // * we need to set the initail state of the counter
  // * which is CounterState() with counterValue 0
  CounterCubit()
      : super(
          const CounterState(
            counterValue: 0,
            wasIncremented: true,
          ),
        );

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
