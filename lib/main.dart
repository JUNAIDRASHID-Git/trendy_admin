import 'package:admin_pannel/presentation/home/bloc/home_bloc.dart';
import 'package:admin_pannel/presentation/home/bloc/home_event.dart';
import 'package:admin_pannel/presentation/product/pages/bloc/product_bloc.dart';
import 'package:admin_pannel/presentation/users/bloc/user_bloc.dart';
import 'package:admin_pannel/presentation/users/bloc/user_event.dart';
import 'package:admin_pannel/responsive/desktop_layout.dart';
import 'package:admin_pannel/responsive/mobile_layout.dart';
import 'package:admin_pannel/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
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
        // Add more blocs here if needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: ResponsiveLayout(
          mobileLayout: MobileLayout(),
          desktopLayout: DesktopLayout(),
        ),
      ),
    );
  }
}
