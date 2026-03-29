import 'package:brand/core/sharedWidgets/basic_button.dart';
import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/core/sharedWidgets/mixed_bg.dart';
import 'package:brand/core/utils/appImages/png_images.dart';
import 'package:brand/features/onboarding/presentation/views/widgets/onboarding_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // الـ Stack هنا عشان الخلفية تكون ثابتة تحت كل الصفحات
      body: Stack(
        children: [
          MixedBg(
            lightColor: BasicColors.linearGradientLight,
            darkColor: BasicColors.linearGradientDark,
          ),

          Column(
            children: [
              // 1. الجزء المتغير (الصور والكلام)
              Expanded(
                child: PageView(
                  controller: _controller,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: [
                    //  السكرينة الأولى
                    OnboardingBody(
                      image: PngImages.womenOnlineShopping,
                      t1: 'Your Local Shopping',
                      t2: 'Hub',
                      s1: 'Explore unique Egyptian',
                      s2: 'brands effortlessly',
                    ),
                    //  السكرينة التانيه
                    OnboardingBody(
                      image: PngImages.onlineShopping,
                      t1: 'The Home of Local',
                      t2: 'Egyptian Brands',
                      s1: 'Find, explore, and shop',
                      s2: 'from trusted local sellers',
                    ),
                  ],
                ),
              ),

              // 2. الجزء الثابت (الزرار والاندكيتور)
              Padding(
                padding: EdgeInsets.only(bottom: 50.h, left: 20.w, right: 20.w),
                child: Column(
                  children: [
                    BasicButton(
                      onPressed: () {
                        if (_currentPage == 1) {
                          Navigator.pushReplacementNamed(context, '/welcome');
                        } else {
                          // انقلي للصفحة التانية
                          _controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        }
                      },

                      text: _currentPage == 1 ? "Get Started" : "Next",
                      colors: [BasicColors.buttonColorDark],

                      radius: 24,
                    ),
                    SizedBox(height: 30.h),

                    // النقطتين (Indicator)
                    SmoothPageIndicator(
                      controller: _controller,
                      count: 2,
                      effect: ExpandingDotsEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        activeDotColor: Colors.white,
                        dotColor: Colors.white.withValues(alpha: 0.4),
                        expansionFactor: 3,
                        spacing: 8,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
