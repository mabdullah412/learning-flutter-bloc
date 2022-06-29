import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> with HydratedMixin {
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

  // ! onChange() is used for debugging bloc/cubit
  // @override
  // void onChange(Change<CounterState> change) {
  //   print(change);
  //   super.onChange(change);
  // }

  // ! onError() is used for debugging and error handling bloc/cubit
  // @override
  // void onError(Object error, StackTrace stackTrace) {
  //   print('$error, $stackTrace');
  //   super.onError(error, stackTrace);
  // }

  // ! the below 2 methods are necessary for hydratedMixin
  // ! because they are needed while storing data to and getting from
  // ! local storage

  // * fromJson is called everytime the app needs the
  // * locally stored data
  @override
  CounterState? fromJson(Map<String, dynamic> json) {
    // ! hydratedBloc will call this fromJson and retrieve the json
    // ! which is already converted into a map

    // * here we return a new instance of CounterState
    // * populated with data retrieved from local storage

    // adding error manually test onError() function
    // addError(Exception('Error added manualy'), StackTrace.current);

    return CounterState.fromMap(json);
  }

  // * toJson is called when at every state emiited by the cubit
  @override
  Map<String, dynamic>? toJson(CounterState state) {
    // * whenever a new state is emitted with a new value,
    // * we want to store it in a Map and send it to hydratedbloc
    // * to store on the local storeage
    return state.toMap();
  }
}
