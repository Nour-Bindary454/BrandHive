import 'package:brand/core/sharedWidgets/basic_colors.dart';
import 'package:brand/core/sharedWidgets/basic_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollectionsContainer extends StatefulWidget {
  const CollectionsContainer({super.key, required this.onTap});
  final void Function()? onTap;
  @override
  State<CollectionsContainer> createState() => _CollectionsContainerState();
}

class _CollectionsContainerState extends State<CollectionsContainer> {
  List<String> CollectionName = ['New Arrivals', 'Best Sellers', 'Ramadan'];
  List<String> itemsNumber = ["45", "32", 'Festive decors'];
  List<Color> boxColorsLight = [
    BasicColors.linearGradientLight,
    Color(0xffAD46FF),
    Color(0xff615FFF),
  ];
  List<Color> boxColorsDark = [
    BasicColors.linearGradientDark,
    Color(0xff361A4B),
    Color(0xff155DFC),
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: CollectionName.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: widget.onTap,
            child: Container(
              width: 210.w,
              margin: EdgeInsets.only(right: 15),
              padding: EdgeInsets.all(16),
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
                    text: CollectionName[index],
                    fontSize: 17,
                    color: Theme.of(context).cardColor,
                    isBold: true,
                  ),
                  BasicText(
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
