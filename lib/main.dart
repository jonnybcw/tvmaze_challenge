import 'dart:convert';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:tvmaze_challenge/config/hive_config.dart';
import 'package:tvmaze_challenge/data/repositories/people_repository.dart';
import 'package:tvmaze_challenge/data/repositories/shows_repository.dart';
import 'package:tvmaze_challenge/modules/core/core_screen.dart';

Future<void> main() async {
  Bloc.transformer = sequential<dynamic>();
  await HiveConfig.init();
  registerRepositories();

  const FlutterSecureStorage secureStorage = FlutterSecureStorage();
  String? encryptionKey = await secureStorage.read(key: 'encryptionKey');
  if (encryptionKey == null) {
    List<int> key = Hive.generateSecureKey();
    await secureStorage.write(
      key: 'encryptionKey',
      value: base64UrlEncode(key),
    );
  }

  runApp(const MyApp());
}

void registerRepositories() {
  GetIt.I.registerSingleton<ShowsRepository>(ShowsRepository());
  GetIt.I.registerSingleton<PeopleRepository>(PeopleRepository());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TVmaze',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.6),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Colors.white,
          circularTrackColor: Colors.grey,
        ),
        textTheme: Typography.whiteMountainView,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        dialogBackgroundColor: Colors.black,
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white.withOpacity(0.1),
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(16),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(16),
          ),
          prefixIconColor: Colors.white,
        ),
      ),
      home: const CoreScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
