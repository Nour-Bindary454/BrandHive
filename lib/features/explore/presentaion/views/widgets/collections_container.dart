import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:brand/features/newArrivals/presentation/viewModel/new_arrivals_cubit.dart';
import 'package:brand/features/newArrivals/presentation/viewModel/new_arrivals_states.dart';
import 'package:brand/features/newArrivals/presentation/views/new_arrivals_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:brand/core/services/service_locator.dart';

class CollectionsContainer extends StatefulWidget {
  const CollectionsContainer({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  State<CollectionsContainer> createState() => _CollectionsContainerState();
}

class _CollectionsContainerState extends State<CollectionsContainer> {
  final newArrivalsCubit = sl<NewArrivalsCubit>();

  List<String> collectionName = ['New Arrivals', 'Best Sellers', 'Ramadan'];

  List<String> itemsNumber = ["45", "32", 'Festive decors'];

  List<Color> boxColorsLight = [
    BasicColors.linearGradientLight,
    const Color(0xffAD46FF),
    const Color(0xff615FFF),
  ];

  List<Color> boxColorsDark = [
    BasicColors.linearGradientDark,
    const Color(0xff361A4B),
    const Color(0xff155DFC),
  ];

  @override
  void initState() {
    super.initState();
    newArrivalsCubit.getNewArrivals();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: collectionName.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: newArrivalsCubit,
                      child: const NewArrivalsScreen(),
                    ),
                  ),
                );
              }
            },
            child: Container(
              width: 210.w,
              margin: const EdgeInsets.only(right: 15),
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.r),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [boxColorsLight[index], boxColorsDark[index]],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BasicText(
                    text: collectionName[index],
                    fontSize: 17,
                    color: Theme.of(context).cardColor,
                    isBold: true,
                  ),
                  SizedBox(height: 6.h),
                  index == 0
                      ? BlocBuilder<NewArrivalsCubit, NewArrivalsState>(
                          bloc: newArrivalsCubit,
                          builder: (context, state) {
                            String count = "0";
                            if (state is NewArrivalsSuccess) {
                              count = state.products.length.toString();
                            } else if (newArrivalsCubit.products.isNotEmpty) {
                              count = newArrivalsCubit.products.length
                                  .toString();
                            }
                            return BasicText(
                              text: "$count items",
                              fontSize: 15,
                              color: Theme.of(context).cardColor,
                              isBold: false,
                            );
                          },
                        )
                      : BasicText(
                          text: "${itemsNumber[index]} items",
                          fontSize: 15,
                          color: Theme.of(context).cardColor,
                          isBold: false,
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
