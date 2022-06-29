import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(
          const SettingsState(
            appNotifications: false,
            emailNotifications: false,
          ),
        );

  void toggleAppNotifications(newVal) {
    // ! never modify and send a current state
    // ! ex: state.appNotifications = newVal
    // ! because bloc won't consecutively emit 2 identical states

    // ! always send a new state
    emit(state.copyWith(appNotifications: newVal));
  }

  void toggleEmailNotifications(newVal) {
    emit(state.copyWith(emailNotifications: newVal));
  }
}
