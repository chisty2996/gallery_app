import 'package:flutter/material.dart';
import 'package:gallery_app/core/routes/route_generator.dart';
import 'package:gallery_app/core/theme/theme.dart';
import 'package:gallery_app/dependency_injection.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: RouteGenerator.router,

      title: 'Gallery',
      theme: theme(),
      debugShowCheckedModeBanner: false,
      builder: (context, child){
        return Scaffold(body: child,);
      },

    );
  }
}

