import 'package:flutter/material.dart';
import 'package:umbrella_listing/core/config/flavor_config.dart';
import 'package:umbrella_listing/main_common.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize staging flavor
  FlavorConfig.initialize(FlavorConfig.staging);

  // Run common main
  await mainCommon();
}
