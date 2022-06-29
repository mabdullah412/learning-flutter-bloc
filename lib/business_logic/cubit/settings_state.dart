part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    required this.appNotifications,
    required this.emailNotifications,
  });

  final bool appNotifications;
  final bool emailNotifications;

  // ! creates a new instance of the SettingsState
  // ! with the given new value,
  // ! and not given old value
  SettingsState copyWith({
    bool? appNotifications,
    bool? emailNotifications,
  }) {
    return SettingsState(
      appNotifications: appNotifications ?? this.appNotifications,
      emailNotifications: emailNotifications ?? this.emailNotifications,
    );
  }

  @override
  List<Object> get props => [appNotifications, emailNotifications];
}
