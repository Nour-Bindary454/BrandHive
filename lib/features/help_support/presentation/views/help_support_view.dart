import 'package:brand/core/sharedWidgets/backarrow.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/services/service_locator.dart';
import 'package:brand/features/help_support/presentation/viewModel/support_cubit.dart';
import 'package:brand/features/help_support/presentation/views/widgets/contact_cards_section.dart';
import 'package:brand/features/help_support/presentation/views/widgets/support_form_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HelpSupportView extends StatelessWidget {
  const HelpSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SupportCubit>(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA), // Off-white background
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      const CustomBackarrow(),
                      SizedBox(width: 20.w),
                      BasicText(
                        text: "Help & Support",
                        fontSize: 20.sp,
                        color: const Color(0xFF1E293B),
                        isBold: true,
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  const ContactCardsSection(),
                  SizedBox(height: 30.h),
                  const SupportFormSection(),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
