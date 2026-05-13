import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/sharedWidgets/basic_button.dart';
import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/core/services/service_locator.dart';
import '../viewmodels/address_cubit.dart';
import '../viewmodels/address_state.dart';
import 'widgets/address_card.dart';
import 'add_edit_address_screen.dart';

class AddressListScreen extends StatelessWidget {
  const AddressListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AddressCubit>()..fetchAllAddresses(),
      child: Scaffold(
        appBar: AppBar(
          title: BasicText(
            text: 'my_addresses'.tr(),
            fontSize: 18.sp,
            isBold: true,
            color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor:
              Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black,
        ),
        body: BlocConsumer<AddressCubit, AddressState>(
          listener: (context, state) {
            if (state is AddressActionError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            } else if (state is AddressActionSuccess) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            final cubit = context.read<AddressCubit>();

            if (state is AddressLoading && cubit.currentAddresses.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (cubit.currentAddresses.isEmpty) {
              return _buildEmptyState(context);
            }

            return RefreshIndicator(
              onRefresh: () async {
                await cubit.fetchAllAddresses();
              },
              child: ListView.builder(
                padding: EdgeInsets.all(20.w),
                itemCount: cubit.currentAddresses.length,
                itemBuilder: (context, index) {
                  final address = cubit.currentAddresses[index];
                  return AddressCard(
                    address: address,
                    isDefault: address.isDefault,
                    onTap: () {
                      if (!address.isDefault && address.id != null) {
                        cubit.setDefaultAddress(address.id!);
                      }
                    },
                    onEdit: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: cubit,
                            child: AddEditAddressScreen(address: address),
                          ),
                        ),
                      );
                    },
                    onDelete: () {
                      _showDeleteConfirmation(context, cubit, address.id!);
                    },
                  );
                },
              ),
            );
          },
        ),
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: context.read<AddressCubit>(),
                      child: const AddEditAddressScreen(),
                    ),
                  ),
                );
              },
              backgroundColor: BasicColors.buttonColorDark,
              icon: const Icon(Icons.add, color: Colors.white),
              label: BasicText(
                text: 'add_address'.tr(),
                fontSize: 14.sp,
                color: Colors.white,
                isBold: true,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.location_off_outlined, size: 80.sp, color: Colors.grey),
          SizedBox(height: 20.h),
          BasicText(
            text: 'no_addresses_found'.tr(),
            fontSize: 18.sp,
            color: Colors.grey.shade800,
            isBold: true,
          ),
          SizedBox(height: 10.h),
          BasicText(
            text: 'add_a_new_address_to_continue'.tr(),
            fontSize: 14.sp,
            color: Colors.grey.shade500,
            isBold: false,
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    AddressCubit cubit,
    String id,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('delete_address'.tr()),
        content: Text('are_you_sure_delete_address'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'cancel'.tr(),
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              cubit.deleteAddress(id);
            },
            child: Text(
              'delete'.tr(),
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
