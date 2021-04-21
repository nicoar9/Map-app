import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:map_app/bloc/map/map_bloc.dart';
import 'package:map_app/bloc/my_location/my_location_bloc.dart';
import 'package:map_app/bloc/search/search_bloc.dart';

import 'package:map_app/pages/gps_access_page.dart';
import 'package:map_app/pages/loading_page.dart';
import 'package:map_app/pages/map_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => MyLocationBloc(),
        ),
        BlocProvider(
          create: (_) => MapBloc(),
        ),
        BlocProvider(
          create: (_) => SearchBloc(),
        )
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        home: LoadingPage(),
        routes: {
          'map': (_) => MapPage(),
          'loading': (_) => LoadingPage(),
          'gps_access': (_) => GpsAccessPage()
        },
      ),
    );
  }
}
