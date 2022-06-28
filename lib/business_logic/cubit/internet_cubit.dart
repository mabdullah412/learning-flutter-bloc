import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_concepts/constants/enums.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  // * from connectivity_plus plugin
  final Connectivity connectivity;

  // * creating a stream subscription so that we can
  // * subscribe to it
  late StreamSubscription connectivityStreamSubscription;
  // * now we initialize this stream in the constructor by subscribing
  // * to the onConnectivityChanged stream from connectivity_plus plugin

  // * when the internet cubit constructor gets called
  // * the first state emitted is the InternetLoading state
  InternetCubit({required this.connectivity}) : super(InternetLoading()) {
    // * whenever a new connection is noticed by the connectivity_plus plugin
    // * the onConnectivityChanged stream will send a connectivity result.
    // * we will check it and emit the corresponding state
    monitorInternetConnection();
  }

  StreamSubscription<ConnectivityResult> monitorInternetConnection() {
    return connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen(
      (connectivityResult) {
        if (connectivityResult == ConnectivityResult.wifi) {
          emitInternetConnected(ConnectionType.wifi);
        } else if (connectivityResult == ConnectivityResult.mobile) {
          emitInternetConnected(ConnectionType.mobile);
        } else {
          // connectivityResult == ConnectivityResult.none
          emitInternetDisconnected();
        }
      },
    );
  }

  void emitInternetConnected(ConnectionType connectionType) {
    emit(InternetConnected(connectionType: connectionType));
  }

  void emitInternetDisconnected() {
    emit(InternetDisconnected());
  }

  // ! closing the subsscription after the bloc/cubit is closed
  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
