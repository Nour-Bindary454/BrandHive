import 'package:brand/core/sharedWidgets/backarrow.dart';
import 'package:brand/core/sharedWidgets/basic_button.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/core/sharedWidgets/basic_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HelpSupportView extends StatefulWidget {
  const HelpSupportView({super.key});

  @override
  State<HelpSupportView> createState() => _HelpSupportViewState();
}

class _HelpSupportViewState extends State<HelpSupportView> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Off-white background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                // Header row
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

                // Contact Cards
                Row(
                  children: [
                    Expanded(
                      child: _buildContactCard(
                        icon: Icons.email_outlined,
                        iconColor: const Color(0xFFE27B5A),
                        title: "EMAIL",
                        subtitle: "hello@brandhive.eg",
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: _buildContactCard(
                        icon: Icons.phone_outlined,
                        iconColor: const Color(0xFFE34848),
                        title: "PHONE",
                        subtitle: "+20 100 XXX",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),

                // Message Form Container
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BasicText(
                        text: "Send a Message",
                        fontSize: 22.sp,
                        color: const Color(0xFF2D4373),
                        isBold: true,
                      ),
                      SizedBox(height: 25.h),

                      // Full Name
                      BasicTextField(
                        label: "Full Name",
                        hint: "Your name",
                        controller: nameController,
                        isPassword: false,
                      ),

                      // Email
                      BasicTextField(
                        label: "Email",
                        hint: "you@example.com",
                        controller: emailController,
                        isPassword: false,
                      ),

                      // Message
                      BasicText(
                        text: "Message",
                        fontSize: 12.sp,
                        color: const Color(0xFF5B5B5C),
                        isBold: true,
                      ),
                      SizedBox(height: 8.h),
                      // Custom TextField for multiline
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: TextField(
                          controller: messageController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: "How can we help?",
                            hintStyle: TextStyle(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 14.sp,
                              fontFamily: 'Poppins',
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(15.w),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),

                      // Send Message Button
                      BasicButton(
                        text: "Send Message",
                        colors: const [Color(0xFF2D4373)],
                        radius: 12.r,
                        onPressed: () {
                          // Handle send message logic
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 28.sp),
          SizedBox(height: 10.h),
          BasicText(
            text: title,
            fontSize: 12.sp,
            color: const Color(0xFF6B7280),
            isBold: true,
          ),
          SizedBox(height: 5.h),
          BasicText(
            text: subtitle,
            fontSize: 13.sp,
            color: const Color(0xFF1E293B),
            isBold: true,
          ),
        ],
      ),
    );
  }
}
