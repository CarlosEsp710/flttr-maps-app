import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maps/bloc/location/location_bloc.dart';
import 'package:maps/bloc/map/map_bloc.dart';

import 'package:maps/routes/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LocationBloc()),
        BlocProvider(create: (_) => MapBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Maps App',
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }
}
