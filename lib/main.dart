import 'package:flutter/material.dart';
import 'package:tr_store_app/config/theme/app_themes.dart';
import 'package:tr_store_app/features/product_list/presentation/view/product_list_screen.dart';

import 'config/di/injection_container.dart';
import 'config/routes/routes.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        home: const ProductListScreen()
    );
  }
}

