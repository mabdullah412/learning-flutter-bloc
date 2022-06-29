import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_concepts/business_logic/cubit/settings_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: BlocConsumer<SettingsCubit, SettingsState>(
        listener: (context, state) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'App: ${state.appNotifications}, Email: ${state.emailNotifications}',
              ),
              duration: const Duration(milliseconds: 500),
            ),
          );
        },
        builder: (context, state) {
          return Column(
            children: [
              SwitchListTile(
                value: state.appNotifications,
                title: const Text('App Notifications'),
                onChanged: (newVal) {
                  BlocProvider.of<SettingsCubit>(context)
                      .toggleAppNotifications(newVal);
                },
              ),
              SwitchListTile(
                value: state.emailNotifications,
                title: const Text('Email Notifications'),
                onChanged: (newVal) {
                  context
                      .read<SettingsCubit>()
                      .toggleEmailNotifications(newVal);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
