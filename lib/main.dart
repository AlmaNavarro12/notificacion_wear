import 'package:contadorwear/view/ambient_screen.dart';
import 'package:contadorwear/view/notification_services.dart';
import 'package:contadorwear/view/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:wear/wear.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initNotifications();  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Wear App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const WatchScreen(),
        debugShowCheckedModeBanner: false,
      );
}

class WatchScreen extends StatelessWidget {
  const WatchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => WatchShape(
        // ignore: deprecated_member_use
        builder: (context, shape, child) => InheritedShape(
          shape: shape,
          child: AmbientMode(
            builder: (context, mode, child) => mode == WearMode.active
                ? const HomePage()
                : AmbientWatchFace(),
          ),
        ),
      );
}
