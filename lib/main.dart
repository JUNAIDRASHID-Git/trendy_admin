import 'package:admin_pannel/core/services/api/order/order_websocket_service.dart';
import 'package:admin_pannel/presentation/pages/admins/bloc/admin_bloc.dart';
import 'package:admin_pannel/presentation/pages/admins/bloc/admin_event.dart';
import 'package:admin_pannel/presentation/pages/home/bloc/home_bloc.dart';
import 'package:admin_pannel/presentation/pages/home/bloc/home_event.dart';
import 'package:admin_pannel/presentation/pages/product/bloc/product_bloc.dart';
import 'package:admin_pannel/presentation/pages/category/bloc/category_bloc.dart';
import 'package:admin_pannel/presentation/pages/category/bloc/category_event.dart';
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
      apiKey: "AIzaSyCkCcI9xWyxcdyfuQHyorkrDvi9IB8_Xn4",
      authDomain: "trendy-c-57ade.firebaseapp.com",
      projectId: "trendy-c-57ade",
      storageBucket: "trendy-c-57ade.firebasestorage.app",
      messagingSenderId: "156938940217",
      appId: "1:156938940217:web:73301befe1a655b1c082e8",
      measurementId: "G-MQLLMN0F5P",
    ),
  );

  OrderAlertService().start(
    "wss://server.trendy-c.com/orders/ws/orders",
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
