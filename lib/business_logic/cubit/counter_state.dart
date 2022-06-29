part of 'counter_cubit.dart';

// * Equatable class helps in comparing 2 objects
// * sometimes the values of the 2 instances are same,
// * but because they are 2 different instances on different
// * memory location, dart returns False,
// * so we use Equatable package here.

// * So with Equatable package 2 instances with same values
// * trick dart to return True

class CounterState extends Equatable {
  const CounterState({
    required this.counterValue,
    required this.wasIncremented,
  });

  final int counterValue;
  final bool wasIncremented;

  // * props are a way of indicating Equatable
  // * hich are the fields in our class, that we want
  // * to be compared while aplying the equal operator.

  @override
  List<Object?> get props => [counterValue, wasIncremented];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'counterValue': counterValue,
      'wasIncremented': wasIncremented,
    };
  }

  factory CounterState.fromMap(Map<String, dynamic> map) {
    return CounterState(
      counterValue: map['counterValue'] as int,
      wasIncremented: map['wasIncremented'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory CounterState.fromJson(String source) =>
      CounterState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CounterState(counterValue: $counterValue, wasIncremented: $wasIncremented)';
}
