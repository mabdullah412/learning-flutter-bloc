// import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc_concepts/business_logic/cubit/counter_cubit.dart';
import 'package:flutter_bloc_concepts/business_logic/cubit/internet_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // * a group is a way of organizing multiple tests
  // * for a feature

  // * for example
  // * in our CounterCubit group we will write
  // * all the test necessary for the counter feature

  group('CounterCubit', () {
    // * inside a setUp function, we can instantiate objects
    // * and necessary data,
    // * that our tests will be working with
    CounterCubit counterCubit;
    counterCubit = CounterCubit();

    setUp(() {
      // ? why is this not working,
      // ? why is it giving err when not initialinzing
      // ? outside this function

      counterCubit = CounterCubit();
    });

    // * tearDown is a funtion that will get called after each
    // * test is run.
    // * It will apply only to the test in this group.
    tearDown(() {
      counterCubit.close();
    });

    // ! TEST 1,
    // * is going to be checking if the initail state of our counterCubit
    // * is equal to the counterState with a counterValue of zero.
    test(
      'the initials state for the CounterCubit is CounterState(counterValue: 0)',
      () {
        // * expect(actualValue, expectedValue);

        expect(
          counterCubit.state,
          const CounterState(counterValue: 0, wasIncremented: true),
        );
      },
    );

    // ! TEST 2,
    // * will be testing increment function
    // * using bloc_test library here
    // * because we need to test the output as a
    // * response to Increment or Decrement functions
    blocTest(
      'the cubit should emit a CounterState(counterValue: 1, wasIncremented: true) when cubit.increment() function is called',

      // * build, returns current instance of the counterCubit,
      // * to make it availible to the testing process.
      build: () => counterCubit,

      // * act, will take a cubit and will return the action
      // * applied in it.
      act: (cubit) => counterCubit.increment(),

      // * expect, verifies if the order of the states and the
      // * actual emitted states correspond
      expect: () => [const CounterState(counterValue: 1, wasIncremented: true)],
    );

    // ! TEST 3,
    // * will be testing decrement function
    // * using bloc_test library here
    // * because we need to test the output as a
    // * response to Increment or Decrement functions
    blocTest(
      'the cubit should emit a CounterState(counterValue: -1, wasIncremented: false) when cubit.decrement() function is called',

      // * build, returns current instance of the counterCubit,
      // * to make it availible to the testing process.
      build: () => counterCubit,

      // * act, will take a cubit and will return the action
      // * applied in it.
      act: (cubit) => counterCubit.decrement(),

      // * expect, verifies if the order of the states and the
      // * actual emitted states correspond
      expect: () =>
          [const CounterState(counterValue: -1, wasIncremented: false)],
    );
  });
}
