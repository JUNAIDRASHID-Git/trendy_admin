import 'package:admin_pannel/presentation/pages/orders/widgets/builders/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_pannel/presentation/pages/orders/bloc/order_bloc.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage>
    with SingleTickerProviderStateMixin {
  String _searchQuery = '';
  String _statusFilter = 'all';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: BlocProvider(
        create: (context) => OrderBloc()..add(FetchOrdersEvent()),
        child: Column(
          children: [
            _buildHeader(),
            _buildFilters(),
            Expanded(child: _buildOrdersList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
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
            child: TextField(
              onChanged: (value) => setState(() => _searchQuery = value),
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
            ),
          ),
          const SizedBox(width: 16),
          DropdownButton<String>(
            value: _statusFilter,
            onChanged: (value) => setState(() => _statusFilter = value!),
            items: const [
              DropdownMenuItem(value: 'all', child: Text('All Status')),
              DropdownMenuItem(value: 'pending', child: Text('Pending')),
              DropdownMenuItem(value: 'confirmed', child: Text('Confirmed')),
              DropdownMenuItem(value: 'shipped', child: Text('Shipped')),
              DropdownMenuItem(value: 'delivered', child: Text('Delivered')),
              DropdownMenuItem(value: 'cancelled', child: Text('Cancelled')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList() {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state is OrderLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is OrderError) {
          return Center(
            child: Text(state.error, style: const TextStyle(color: Colors.red)),
          );
        } else if (state is OrderLoaded) {
          final filteredOrders =
              state.orders.where((order) {
                final matchesSearch =
                    order.id.toString().contains(_searchQuery) ||
                    order.user.name.toLowerCase().contains(
                      _searchQuery.toLowerCase(),
                    );
                final matchesStatus =
                    _statusFilter == 'all' || order.status == _statusFilter;
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
  }
}
