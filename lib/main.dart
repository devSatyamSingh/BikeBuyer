import 'package:bikebuyer/page/splashpage.dart';
import 'package:bikebuyer/widget/vehicaleprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'homepages/location_provider.dart';

final RouteObserver<PageRoute> routeObserver =
RouteObserver<PageRoute>();

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocationProvider(),
        ),
        ChangeNotifierProvider(create: (_) => VehicleProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bike Buyer',
      navigatorObservers: [routeObserver],
      theme: ThemeData(
        colorScheme:
        ColorScheme.fromSeed(seedColor: Colors.purple),
      ),
      home: SplashScreen(),
    );
  }
}