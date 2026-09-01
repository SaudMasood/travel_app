import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/theme/app_theme.dart';

import 'core/services/api_service.dart';

import 'features/home/bloc/home_bloc.dart';
import 'features/home/screen/home_screen.dart';

void main() {
  runApp(const TravelApp());
}

class TravelApp extends StatelessWidget {
  const TravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(
        ApiService(),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Travel App',
        theme: AppTheme.lightTheme,
        home: const HomeScreen(),
      ),
    );
  }
}