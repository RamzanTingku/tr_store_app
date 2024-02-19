import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tr_store_app/config/theme/app_themes.dart';
import 'package:tr_store_app/features/cart/presentation/provider/cart_provider.dart';
import 'package:tr_store_app/features/product_list/presentation/provider/product_list_provider.dart';
import 'package:tr_store_app/features/product_list/presentation/view/product_list_screen.dart';

import 'config/routes/routes.dart';
import 'core/networking/internet_connectivity.dart';
import 'di/injection_container.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    InternetConnectivity().subscribeConnectivityLister();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductListProvider>(
            create: (context) => ProductListProvider()),
        ChangeNotifierProvider<CartProvider>(
            create: (context) => CartProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: appTheme(),
          navigatorKey: navigatorKey,
          onGenerateRoute: AppRoutes.onGenerateRoutes,
          home: const ProductListScreen()
      ),
    );
  }

  @override
  void dispose() {
    InternetConnectivity().closeSubscriptions();
    super.dispose();
  }
}

