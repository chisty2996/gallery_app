import 'package:flutter/material.dart';
import 'package:umbrella_listing/core/config/flavor_config.dart';
import 'package:umbrella_listing/core/config/theme/app_theme.dart';
import 'package:umbrella_listing/core/di/injection_container.dart';
import 'package:umbrella_listing/core/network/dio_client.dart';

class UmbrellaApp extends StatelessWidget {
  const UmbrellaApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Set base URL for Dio client
    final dioClient = getIt<DioClient>();
    dioClient.setBaseUrl(FlavorConfig.config.baseUrl);

    return MaterialApp(
      title: FlavorConfig.config.appName,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.umbrella, size: 80),
              SizedBox(height: 16),
              Text(
                'Umbrella Listing',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Production-Ready Flutter Application'),
            ],
          ),
        ),
      ),
    );
  }
}
