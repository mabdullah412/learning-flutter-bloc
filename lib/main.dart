import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'business_logic/cubit/counter_cubit.dart';
import 'business_logic/cubit/internet_cubit.dart';
import 'business_logic/cubit/settings_cubit.dart';
import 'presentation/router/app_router.dart';

void main() async {
  // ! necessary to call the native code
  WidgetsFlutterBinding.ensureInitialized();
  // ! native code is used while calling
  // ! getApplicationDocumentsDirectory()

  // * HydratedStorage.build() asyncronously creates the connection
  // * from Hydratedbloc to the storage.

  // * getApplicationDocumentsDirectory() is a method provided
  // * by the path_provider library

  // * getApplicationDocumentsDirectory() points to your applications
  // * storage in the device

  // HydratedBloc.storage = await HydratedStorage.build(
  //   storageDirectory: await getApplicationDocumentsDirectory(),
  // );

  // runApp(MyApp(
  //   appRouter: AppRouter(),
  //   connectivity: Connectivity(),
  // ));

  // ! below is a some kind of turn-around of the above commented code
  // ! which has stopped working due to a bug in flutter
  HydratedBlocOverrides.runZoned(
    () => runApp(
      MyApp(appRouter: AppRouter(), connectivity: Connectivity()),
    ),
    storage: await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.appRouter,
    required this.connectivity,
  }) : super(key: key);

  final AppRouter appRouter;
  final Connectivity connectivity;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => InternetCubit(connectivity: connectivity),
        ),
        BlocProvider(
          create: (context) => CounterCubit(),
        ),
        BlocProvider(
          create: (context) => SettingsCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
