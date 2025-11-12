import 'package:flutter/material.dart';
import 'package:umbrella_listing/app.dart';
import 'package:umbrella_listing/core/di/injection_container.dart';
import 'package:umbrella_listing/core/storage/hive_storage_service.dart';

Future<void> mainCommon() async {
  // Initialize dependencies
  await configureDependencies();

  // Initialize Hive storage
  final hiveStorage = getIt<HiveStorageService>();
  await hiveStorage.init();

  // Run app
  runApp(const UmbrellaApp());
}
