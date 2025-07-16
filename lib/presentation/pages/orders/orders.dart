import 'package:admin_pannel/presentation/pages/orders/widgets/builders/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_pannel/presentation/pages/orders/bloc/order_bloc.dart';

class OrdersPage extends StatelessWidget {
  OrdersPage({super.key});

  final ValueNotifier<String> _searchQuery = ValueNotifier('');
  final ValueNotifier<String> _statusFilter = ValueNotifier('all');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: BlocProvider(
        create: (context) => OrderBloc()..add(FetchOrdersEvent()),
        child: Column(
          children: [
            _buildHeader(context),
            _buildFilters(),
            Expanded(child: _buildOrdersList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2)),
      ),
      child: Row(
        children: [
          const Text(
            'Orders',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => context.read<OrderBloc>().add(FetchOrdersEvent()),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: ValueListenableBuilder<String>(
              valueListenable: _searchQuery,
              builder: (context, value, _) {
                return TextField(
                  onChanged: (val) => _searchQuery.value = val,
                  decoration: InputDecoration(
                    hintText: 'Search orders...',
                    prefixIcon: const Icon(Icons.search, size: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          ValueListenableBuilder<String>(
            valueListenable: _statusFilter,
            builder: (context, value, _) {
              return DropdownButton<String>(
                value: value,
                onChanged: (val) {
                  if (val != null) _statusFilter.value = val;
                },
                items: const [
                  DropdownMenuItem(value: 'all', child: Text('All Status')),
                  DropdownMenuItem(value: 'pending', child: Text('Pending')),
                  DropdownMenuItem(
                    value: 'confirmed',
                    child: Text('Confirmed'),
                  ),
                  DropdownMenuItem(value: 'shipped', child: Text('Shipped')),
                  DropdownMenuItem(
                    value: 'delivered',
                    child: Text('Delivered'),
                  ),
                  DropdownMenuItem(
                    value: 'cancelled',
                    child: Text('Cancelled'),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList() {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        return ValueListenableBuilder<String>(
          valueListenable: _searchQuery,
          builder: (context, query, _) {
            return ValueListenableBuilder<String>(
              valueListenable: _statusFilter,
              builder: (context, status, _) {
                if (state is OrderLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is OrderError) {
                  return Center(
                    child: Text(
                      state.error,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else if (state is OrderLoaded) {
                  final filteredOrders =
                      state.orders.where((order) {
                        final matchesSearch =
                            order.id.toString().contains(query) ||
                            order.user.name.toLowerCase().contains(
                              query.toLowerCase(),
                            );
                        final matchesStatus =
                            status == 'all' || order.status == status;
                        return matchesSearch && matchesStatus;
                      }).toList();

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredOrders.length,
                    itemBuilder:
                        (context, index) =>
                            buildOrderCard(filteredOrders[index], context),
                  );
                }
                return const SizedBox.shrink();
              },
            );
          },
        );
      },
    );
  }
}
