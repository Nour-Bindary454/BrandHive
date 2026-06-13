import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/utils/toast/toast.dart';
import 'package:brand/features/main_layout/presentation/view_model/nav_cubit.dart';
import 'package:brand/features/seller/products/widgets/card.dart';
import 'package:brand/features/seller/presentation/view_model/seller_cubit.dart';
import 'package:brand/features/seller/presentation/view_model/seller_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: BlocConsumer<SellerCubit, SellerState>(
            listener: (context, state) {
              if (state is SellerProductActionSuccess) {
                Toast.showSuccessToast(msg: state.message.tr(), context: context);
              } else if (state is SellerProductActionFailure) {
                Toast.showErrorToast(msg: state.error.tr(), context: context);
              }
            },
            builder: (context, state) {
              final cubit = context.read<SellerCubit>();
              final filteredProducts = cubit.products.where((product) {
                return product.name.toLowerCase().contains(_searchQuery.toLowerCase());
              }).toList();

              final isLoading = state is SellerProductsLoading && cubit.products.isEmpty;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BasicText(
                        text: 'my_products'.tr(),
                        fontSize: 20,
                        color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
                        isBold: true,
                      ),
                      // Quick add indicator redirect
                      IconButton(
                        icon: const Icon(Icons.add, color: Color(0xFF2D4373)),
                        onPressed: () {
                          cubit.clearEditingProduct();
                          context.read<LayoutCubit>().changeIndex(2);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (val) {
                        setState(() {
                          _searchQuery = val;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search products...'.tr(),
                        prefixIcon: const Icon(Icons.search, color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => cubit.getProducts(),
                      child: isLoading
                          ? const Center(child: CircularProgressIndicator(color: Color(0xFF2D4373)))
                          : filteredProducts.isEmpty
                              ? _buildEmptyState()
                              : ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: filteredProducts.length,
                                  itemBuilder: (context, index) {
                                    final product = filteredProducts[index];
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 15.h),
                                      child: SellerProductCard(
                                        product: product,
                                        onTap: () {
                                          cubit.setEditingProduct(product);
                                          context.read<LayoutCubit>().changeIndex(2);
                                        },
                                        onDelete: () {
                                          _showDeleteConfirmation(context, cubit, product.id);
                                        },
                                      ),
                                    );
                                  },
                                ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 100.h),
        Center(
          child: Column(
            children: [
              Icon(Icons.shopping_bag_outlined, size: 64.sp, color: Colors.grey.shade400),
              SizedBox(height: 16.h),
              BasicText(
                text: 'No products found'.tr(),
                fontSize: 16,
                color: Colors.grey.shade600,
                isBold: true,
              ),
              SizedBox(height: 8.h),
              BasicText(
                text: 'Click the + button to add your first product.'.tr(),
                fontSize: 12,
                color: Colors.grey.shade500,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showDeleteConfirmation(BuildContext context, SellerCubit cubit, String productId) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          title: BasicText(
            text: 'Delete Product?'.tr(),
            fontSize: 16,
            color: const Color(0xFF0F172A),
            isBold: true,
          ),
          content: BasicText(
            text: 'Are you sure you want to delete this product? This action cannot be undone.'.tr(),
            fontSize: 13,
            color: Colors.grey.shade600,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: BasicText(
                text: 'Cancel'.tr(),
                fontSize: 13,
                color: Colors.grey.shade600,
                isBold: true,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                cubit.deleteProduct(productId);
                Navigator.pop(dialogContext);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
              ),
              child: BasicText(
                text: 'Delete'.tr(),
                fontSize: 13,
                color: Colors.white,
                isBold: true,
              ),
            ),
          ],
        );
      },
    );
  }
}
