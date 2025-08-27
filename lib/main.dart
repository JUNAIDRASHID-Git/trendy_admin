import 'package:admin_pannel/core/services/api/order/order_websocket_service.dart';
import 'package:admin_pannel/presentation/pages/admins/bloc/admin_bloc.dart';
import 'package:admin_pannel/presentation/pages/admins/bloc/admin_event.dart';
import 'package:admin_pannel/presentation/pages/home/bloc/home_bloc.dart';
import 'package:admin_pannel/presentation/pages/home/bloc/home_event.dart';
import 'package:admin_pannel/presentation/pages/product/bloc/product_bloc.dart';
import 'package:admin_pannel/presentation/pages/product/pages/category/bloc/category_bloc.dart';
import 'package:admin_pannel/presentation/pages/product/pages/category/bloc/category_event.dart';
import 'package:admin_pannel/presentation/pages/splash/splash.dart';
import 'package:admin_pannel/presentation/pages/ui/widgets/banner/bloc/banner_bloc.dart';
import 'package:admin_pannel/presentation/pages/users/bloc/user_bloc.dart';
import 'package:admin_pannel/presentation/pages/users/bloc/user_event.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCgzDBi6Do4qgGBg_O5QHznEEvrqi_tES0",
      authDomain: "trendy-chef-63c6d.firebaseapp.com",
      projectId: "trendy-chef-63c6d",
      storageBucket: "trendy-chef-63c6d.firebasestorage.app",
      messagingSenderId: "524030203276",
      appId: "1:524030203276:web:e70e7d7dd546665460b2a9",
      measurementId: "G-G2YJW5LF4G",
    ),
  );

  OrderAlertService().start(
    "wss://api.trendy-c.com/orders/ws/orders",
    navigatorKey,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) => UserBloc()..add(FetchUsers()),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc()..add(FetchCountsEvent()),
        ),
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc()..add(FetchProduct()),
        ),
        BlocProvider<AdminBloc>(
          create: (context) => AdminBloc()..add(FetchAllAdmin()),
        ),
        BlocProvider<CategoryBloc>(
          create: (context) => CategoryBloc()..add(FetchCategories()),
        ),
        BlocProvider<BannerBloc>(create: (context) => BannerBloc()),
        // Add more blocs here if needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'Flutter Demo',
        home: SplashPage(),
      ),
    );
  }
}
