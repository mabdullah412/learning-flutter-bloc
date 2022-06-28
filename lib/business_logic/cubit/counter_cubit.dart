import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_concepts/business_logic/cubit/internet_cubit.dart';
import 'package:flutter_bloc_concepts/constants/enums.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  // * counterCubit() now depends on InternetCubit for connectivity
  final InternetCubit internetCubit;
  // * so for connectivity we initialize an InternetCubit in
  // * our counter cubit.

  // * now we need a streamSubscription to subscribe to the
  // * InternetCubit's stream of states
  late StreamSubscription internetStreamSubscription;
  // ! remeber, each bloc/cubit has a stream of states
  // ! that can be subscribed to

  // * we need to set the initail state of the counter
  // * which is CounterState() with counterValue 0
  CounterCubit({required this.internetCubit})
      : super(
          const CounterState(
            counterValue: 0,
            wasIncremented: true,
          ),
        ) {
    monitorInternetCubit();
  }

  monitorInternetCubit() {
    internetStreamSubscription = internetCubit.stream.listen(
      (internetState) {
        if (internetState is InternetConnected &&
            internetState.connectionType == ConnectionType.wifi) {
          increment();
        } else if (internetState is InternetConnected &&
            internetState.connectionType == ConnectionType.mobile) {
          decrement();
        }
      },
    );
  }

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

  // ! closing the subsscription after the bloc/cubit is closed
  @override
  Future<void> close() {
    internetStreamSubscription.cancel();
    return super.close();
  }
}
