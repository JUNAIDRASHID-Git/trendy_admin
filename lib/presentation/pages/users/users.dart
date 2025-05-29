import 'package:admin_pannel/presentation/pages/users/bloc/user_bloc.dart';
import 'package:admin_pannel/presentation/pages/users/bloc/user_event.dart';
import 'package:admin_pannel/presentation/pages/users/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserBloc()..add(FetchUsers()),
      child: Scaffold(
        appBar: AppBar(title: const Text("All Users")),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserError) {
              return Center(child: Text(state.message));
            } else if (state is UserLoaded) {
              final users = state.users;

              if (users.isEmpty) {
                return const Center(child: Text('No users found'));
              }

              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 100,
                        columns: const [
                          DataColumn(label: Text('No.')),
                          DataColumn(label: Text('Picture')),
                          DataColumn(label: Text('Name')),
                          DataColumn(label: Text('Phone')),
                          DataColumn(label: Text('Email')),
                          DataColumn(label: Text('Provider')),
                        ],
                        rows: List<DataRow>.generate(users.length, (index) {
                          final user = users[index];
                          return DataRow(
                            cells: [
                              DataCell(Text('${index + 1}')),
                              DataCell(
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.grey[200],
                                  child: ClipOval(
                                    child: Image.network(
                                      user.picture,
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                      errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                      ) {
                                        return const Icon(Icons.person);
                                      },
                                      loadingBuilder: (
                                        context,
                                        child,
                                        loadingProgress,
                                      ) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return const CircularProgressIndicator(
                                          strokeWidth: 2,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(Text(user.name)),
                              DataCell(Text(user.phone)),
                              DataCell(Text(user.email)),
                              DataCell(Text(user.provider)),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
