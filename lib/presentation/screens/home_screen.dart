import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_concepts/business_logic/cubit/internet_cubit.dart';
import 'package:flutter_bloc_concepts/constants/enums.dart';

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
    // ! here the listener is listening to the internetState
    return BlocListener<InternetCubit, InternetState>(
      listener: (context, state) {
        if (state is InternetConnected &&
            state.connectionType == ConnectionType.wifi) {
          BlocProvider.of<CounterCubit>(context).increment();
        } else if (state is InternetConnected &&
            state.connectionType == ConnectionType.mobile) {
          BlocProvider.of<CounterCubit>(context).decrement();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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

              // Row(
              //   children: [
              //     const Expanded(child: SizedBox()),
              //     FloatingActionButton(
              //       heroTag: 'home-increment-btn',
              //       onPressed: () {
              //         BlocProvider.of<CounterCubit>(context).decrement();
              //       },
              //       tooltip: 'decrement',
              //       elevation: 0,
              //       child: const Icon(Icons.remove),
              //     ),
              //     const Expanded(child: SizedBox()),
              //     FloatingActionButton(
              //       heroTag: 'home-decrement-btn',
              //       onPressed: () {
              //         BlocProvider.of<CounterCubit>(context).increment();
              //       },
              //       tooltip: 'Increment',
              //       elevation: 0,
              //       child: const Icon(Icons.add),
              //     ),
              //     const Expanded(child: SizedBox()),
              //   ],
              // ),

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
      ),
    );
  }
}
