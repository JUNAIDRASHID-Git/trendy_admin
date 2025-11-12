import 'package:admin_pannel/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_pannel/presentation/pages/admins/bloc/admin_bloc.dart';
import 'package:admin_pannel/presentation/pages/admins/bloc/admin_event.dart';

class AdminsPage extends StatelessWidget {
  const AdminsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Admins'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<AdminBloc, AdminState>(
          builder: (context, state) {
            if (state is AdminInitial) {
              return Center(
                child: ElevatedButton(
                  onPressed: () {
                    context.read<AdminBloc>().add(FetchAllAdmin());
                  },
                  child: const Text('Fetch Admins'),
                ),
              );
            } else if (state is AdminLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AdminLoaded) {
              if (state.admins.isEmpty) {
                return const Center(child: Text('No admins found.'));
              }
              return ListView.builder(
                itemCount: state.admins.length,
                itemBuilder: (context, index) {
                  final admin = state.admins[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child:
                          admin.picture.isNotEmpty
                              ? Image.network(
                                admin.picture,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.person, size: 40);
                                },
                              )
                              : const Icon(Icons.person, size: 40),
                    ),
                    title: Text(admin.name),
                    subtitle: Text(admin.email),
                    trailing:
                        admin.approved
                            ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                ),
                                SizedBox(width: 10),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                      Colors.red[400],
                                    ),
                                  ),
                                  onPressed: () {
                                    context.read<AdminBloc>().add(
                                      RejectAdmin(email: admin.email),
                                    );
                                  },
                                  child: Text(
                                    'Reject',
                                    style: TextStyle(
                                      color: AppColors.fontWhite,
                                    ),
                                  ),
                                ),
                              ],
                            )
                            : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                      AppColors.primary,
                                    ),
                                  ),
                                  onPressed: () {
                                    context.read<AdminBloc>().add(
                                      ApproveAdmin(email: admin.email),
                                    );
                                  },
                                  child: Text(
                                    'Approve',
                                    style: TextStyle(
                                      color: AppColors.fontWhite,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                      Colors.red[400],
                                    ),
                                  ),
                                  onPressed: () {
                                    context.read<AdminBloc>().add(
                                      RejectAdmin(email: admin.email),
                                    );
                                  },
                                  child: Text(
                                    'Reject',
                                    style: TextStyle(
                                      color: AppColors.fontWhite,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                  );
                },
              );
            } else if (state is AdminError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
