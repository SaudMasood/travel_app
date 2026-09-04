import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:travel_app/theme/app_theme.dart';
import 'package:travel_app/core/services/api_service.dart';

import 'package:travel_app/features/splash/screen/splash_screen.dart';

import 'package:travel_app/features/home/bloc/home_bloc.dart';

import 'package:travel_app/features/trips/bloc/trip_bloc.dart';
import 'package:travel_app/features/trips/bloc/trip_event.dart';

import 'features/info/block/info_bloc.dart';
import 'features/moreinfo/block/moreinfo_bloc.dart';
import 'features/travelnotes/block/travel_notes_bloc.dart';
import 'features/world_explorer/block/world_explorer_bloc.dart';

void main() {
  runApp(const TravelApp());
}

class TravelApp extends StatelessWidget {
  const TravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(
          create: (_) => HomeBloc(
            ApiService(),
          ),
        ),

        BlocProvider(
          create: (_) => TripBloc(
            ApiService(),
          )..add(const LoadTrips()),
        ),
        BlocProvider(
          create: (_) => MoreInfoBloc(
            ApiService(),
          ),
        ),
        BlocProvider(
          create: (_) => WorldExplorerBloc(
            ApiService(),
          ),
        ),

        BlocProvider(
          create: (_) => TravelNotesBloc(
            ApiService(),
          ),
        ),

        BlocProvider(
          create: (context) => InfoBloc(
            ApiService(),
          ),
        ),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Travel App',
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}