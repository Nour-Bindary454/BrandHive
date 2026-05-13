import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'info_row.dart';
import 'tappable_row.dart';

class InfoCard extends StatelessWidget {
  final List<Widget> children;
  
  const InfoCard({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    final validChildren = children.where((w) => w is InfoRow || w is TappableRow).toList();
    if (validChildren.isEmpty) return const SizedBox.shrink();
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: List.generate(validChildren.length, (i) {
          return Column(children: [
            validChildren[i],
            if (i < validChildren.length - 1)
              Divider(height: 1, indent: 48.w, color: Colors.grey.withOpacity(0.15)),
          ]);
        }),
      ),
    );
  }
}
