import 'package:admin_pannel/presentation/pages/admins/bloc/admin_bloc.dart';
import 'package:admin_pannel/presentation/pages/admins/bloc/admin_event.dart';
import 'package:admin_pannel/presentation/pages/home/bloc/home_bloc.dart';
import 'package:admin_pannel/presentation/pages/home/bloc/home_event.dart';
import 'package:admin_pannel/presentation/pages/product/bloc/product_bloc.dart';
import 'package:admin_pannel/presentation/pages/product/pages/category/bloc/category_bloc.dart';
import 'package:admin_pannel/presentation/pages/splash/splash.dart';
import 'package:admin_pannel/presentation/pages/users/bloc/user_bloc.dart';
import 'package:admin_pannel/presentation/pages/users/bloc/user_event.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBbZSwAKla4HLoCapMPrg5ShlQHWYgFf6g",
      authDomain: "trendy-admin-83285.firebaseapp.com",
      projectId: "trendy-admin-83285",
      storageBucket: "trendy-admin-83285.appspot.com",
      messagingSenderId: "846595955923",
      appId: "1:846595955923:web:861e196aade97c04a70826",
    ),
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
        // Add more blocs here if needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: SplashPage(),
      ),
    );
  }
}
