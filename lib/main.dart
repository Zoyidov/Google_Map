import 'package:flutter/material.dart';
import 'package:login_screen_homework/data/network/repositories/repository.dart';
import 'package:login_screen_homework/data/network/service/api_service.dart';
import 'package:login_screen_homework/data/providers/address_call_provider.dart';
import 'package:login_screen_homework/ui/get_location/get_location.dart';
import 'package:provider/provider.dart';

import 'data/providers/api_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.initializeDatabase();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AddressProvider()),
        ChangeNotifierProvider(
            create: (context) => AddressCallProvider(apiService: ApiService())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LocationAccess(),
    );
  }
}
