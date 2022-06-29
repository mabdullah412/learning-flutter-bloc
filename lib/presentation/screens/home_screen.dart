import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_concepts/business_logic/cubit/internet_cubit.dart';
import 'package:flutter_bloc_concepts/constants/enums.dart';
import 'package:flutter_bloc_concepts/presentation/screens/settings_screen.dart';

import '../../business_logic/cubit/counter_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title, required this.colors})
      : super(key: key);

  final String title;
  final Color colors;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // ! for internet connection
            BlocBuilder<InternetCubit, InternetState>(
              builder: (context, state) {
                if (state is InternetConnected &&
                    state.connectionType == ConnectionType.wifi) {
                  return const Text('Connected To Wifi.');
                } else if (state is InternetConnected &&
                    state.connectionType == ConnectionType.mobile) {
                  return const Text('Connected To Mobile Data.');
                } else if (state is InternetDisconnected) {
                  return const Text('Not Connected To Internet');
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),

            const SizedBox(height: 50),

            const Text(
              'Counter Value:',
            ),

            // ! blocConsumer, with both listener and builder
            BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                if (state.wasIncremented == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Incremented'),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Decremented'),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Text(
                  state.counterValue.toString(),
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),

            const SizedBox(height: 20),

            // ! this is done like this so that
            // ! we can rebuild by monitoring
            // ! multiple blocs/cubits at the same time.
            Builder(
              builder: (context) {
                final counterState = context.watch<CounterCubit>().state;
                final internetState = context.watch<InternetCubit>().state;

                if (internetState is InternetConnected &&
                    internetState.connectionType == ConnectionType.wifi) {
                  return Text(
                    'Counter: ${counterState.counterValue}\nInternet: Wifi',
                    textAlign: TextAlign.center,
                  );
                } else if (internetState is InternetConnected &&
                    internetState.connectionType == ConnectionType.mobile) {
                  return Text(
                    'Counter: ${counterState.counterValue}\nInternet: Mobile',
                    textAlign: TextAlign.center,
                  );
                } else if (internetState is InternetDisconnected) {
                  return Text(
                    'Counter: ${counterState.counterValue}\nInternet: Disconnected',
                    textAlign: TextAlign.center,
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),

            const SizedBox(height: 30),

            Row(
              children: [
                const Expanded(child: SizedBox()),
                FloatingActionButton(
                  heroTag: 'home-increment-btn',
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).decrement();
                  },
                  tooltip: 'decrement',
                  elevation: 0,
                  child: const Icon(Icons.remove),
                ),
                const Expanded(child: SizedBox()),
                FloatingActionButton(
                  heroTag: 'home-decrement-btn',
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).increment();
                  },
                  tooltip: 'Increment',
                  elevation: 0,
                  child: const Icon(Icons.add),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),

            const SizedBox(height: 50),

            MaterialButton(
              color: Colors.redAccent,
              onPressed: () {
                Navigator.of(context).pushNamed('/second');
              },
              child: const Text(
                'Second Screen',
                style: TextStyle(color: Colors.white),
              ),
            ),

            MaterialButton(
              color: Colors.greenAccent,
              onPressed: () {
                Navigator.of(context).pushNamed('/third');
              },
              child: const Text(
                'Third Screen',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
