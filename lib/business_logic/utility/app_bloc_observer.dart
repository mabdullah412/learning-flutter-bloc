import 'package:flutter_bloc/flutter_bloc.dart';

// ! userful when there are too many blocs and we
// ! have to test them all

// ! for example:
// ! the onChange() method will be called due
// ! to any change in any cubit/bloc in the project

class AppBlocObserver extends BlocObserver {
  // ! UPDATE:
  // ! bloc and cubit now extend BlocBase
  // ! so (Blocbase bloc) or (BlocBase cubit)

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print(change);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print(bloc);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }
}
