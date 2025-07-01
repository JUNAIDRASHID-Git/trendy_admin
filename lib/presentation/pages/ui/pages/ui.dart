import 'package:admin_pannel/presentation/pages/ui/bloc/ui_bloc.dart';
import 'package:admin_pannel/presentation/pages/ui/widgets/container/banner_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UiPage extends StatelessWidget {
  const UiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Banner Management")),
      body: BlocProvider(
        create: (context) => UiBloc()..add(BannerFetchEvent()),
        child: BlocBuilder<UiBloc, UiState>(
          builder: (context, state) {
            if (state is UiLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UiError) {
              return Center(child: Text("Error: ${state.error}"));
            } else if (state is UiLoaded) {
              final banners = state.banners;

              return Column(children: [Expanded(
                flex: 3,
                child: BannerManagement(banners: banners))]);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
