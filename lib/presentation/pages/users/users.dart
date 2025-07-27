import 'package:admin_pannel/presentation/pages/users/widgets/usercart/bloc/usercart_bloc.dart';
import 'package:admin_pannel/presentation/pages/users/widgets/usercart/bloc/usercart_event.dart';
import 'package:admin_pannel/presentation/pages/users/widgets/usercart/bloc/usercart_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin_pannel/presentation/pages/users/bloc/user_bloc.dart';
import 'package:admin_pannel/presentation/pages/users/bloc/user_event.dart';
import 'package:admin_pannel/presentation/pages/users/bloc/user_state.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  String? selectedUserId;
  String selectedUserName = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserBloc()..add(FetchUsers()),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.people_outline,
                      size: 28,
                      color: Color(0xFF374151),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Users Management',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF111827),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const Spacer(),
                    if (selectedUserId != null)
                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            selectedUserId = null;
                            selectedUserName = '';
                          });
                        },
                        icon: const Icon(Icons.arrow_back, size: 18),
                        label: const Text('Back to Users'),
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF6B7280),
                        ),
                      ),
                  ],
                ),
              ),

              // Content
              Expanded(
                child:
                    selectedUserId == null
                        ? _buildUsersList()
                        : _buildCartView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUsersList() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Color(0xFF6366F1),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Loading users...',
                  style: TextStyle(color: Color(0xFF6B7280), fontSize: 14),
                ),
              ],
            ),
          );
        } else if (state is UserError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 48,
                  color: Color(0xFFEF4444),
                ),
                const SizedBox(height: 16),
                Text(
                  'Error loading users',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  state.message,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        } else if (state is UserLoaded) {
          final users = state.users;

          if (users.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.people_outline,
                    size: 64,
                    color: Color(0xFFD1D5DB),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No users found',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(24),
            itemCount: users.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final user = users[index];
              return _buildUserCard(user);
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildUserCard(user) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            setState(() {
              selectedUserId = user.id;
              selectedUserName = user.name;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Avatar
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: const Color(0xFFE5E7EB),
                      width: 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child:
                        user.picture != null && user.picture!.isNotEmpty
                            ? Image.network(
                              user.picture!,
                              width: 56,
                              height: 56,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (_, __, ___) => const Icon(
                                    Icons.person,
                                    size: 28,
                                    color: Color(0xFF9CA3AF),
                                  ),
                            )
                            : const Icon(
                              Icons.person,
                              size: 28,
                              color: Color(0xFF9CA3AF),
                            ),
                  ),
                ),

                const SizedBox(width: 16),

                // User Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.email ?? 'No email provided',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),

                // Action Button with Cart Count
                BlocProvider(
                  create: (context) => CartBloc()..add(LoadCartItems(user.id)),
                  child: BlocBuilder<CartBloc, CartState>(
                    builder: (context, cartState) {
                      int cartCount = 0;
                      if (cartState is CartLoaded) {
                        cartCount = cartState.cartItems.length;
                      }

                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6366F1).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFF6366F1).withOpacity(0.2),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.shopping_cart_outlined,
                                  size: 16,
                                  color: const Color(0xFF6366F1),
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  'View Cart',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF6366F1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Cart Count Badge
                          if (cartCount > 0)
                            Positioned(
                              right: -4,
                              top: -4,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFEF4444),
                                  shape: BoxShape.circle,
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 20,
                                  minHeight: 20,
                                ),
                                child: Text(
                                  cartCount > 99 ? '99+' : cartCount.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCartView() {
    return Column(
      children: [
        // Cart Header
        Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  size: 20,
                  color: Color(0xFF6366F1),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$selectedUserName\'s Cart',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const Text(
                    'Cart items and details',
                    style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Cart Content
        Expanded(
          child: BlocProvider(
            create:
                (context) => CartBloc()..add(LoadCartItems(selectedUserId!)),
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartLoading) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Color(0xFF6366F1),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Loading cart items...',
                          style: TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is CartLoaded) {
                  if (state.cartItems.isEmpty) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 64,
                            color: Color(0xFFD1D5DB),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Cart is empty',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'No items found in this user\'s cart',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF9CA3AF),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  double totalAmount = 0;
                  for (var item in state.cartItems) {
                    totalAmount += item.quantity * item.productSalePrice;
                  }

                  return Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.all(24),
                          itemCount: state.cartItems.length,
                          separatorBuilder:
                              (context, index) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final item = state.cartItems[index];
                            return _buildCartItem(item);
                          },
                        ),
                      ),

                      // Total Section
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(color: Color(0xFFE5E7EB), width: 1),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Amount:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF111827),
                              ),
                            ),
                            Text(
                              '${totalAmount.toStringAsFixed(2)} SAR',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF059669),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (state is CartError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 48,
                          color: Color(0xFFEF4444),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Error loading cart',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.message,
                          style: const TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCartItem(item) {
    final itemTotal = item.quantity * item.productSalePrice;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Product Image
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  item.productImage,
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (_, __, ___) => const Icon(
                        Icons.image_not_supported_outlined,
                        color: Color(0xFF9CA3AF),
                        size: 24,
                      ),
                ),
              ),
            ),

            const SizedBox(width: 16),

            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.productEName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildDetailChip(
                        icon: Icons.shopping_basket_outlined,
                        label: '${item.quantity}x',
                        color: const Color(0xFF3B82F6),
                      ),
                      const SizedBox(width: 8),
                      _buildDetailChip(
                        icon: Icons.scale_outlined,
                        label: '${item.weight} kg',
                        color: const Color(0xFF8B5CF6),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${item.productSalePrice} SAR each',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      Text(
                        '${itemTotal.toStringAsFixed(2)} SAR',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF059669),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
