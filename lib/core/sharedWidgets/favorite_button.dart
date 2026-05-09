import 'package:brand/features/wishlist/presentation/viewsModel/wishlist_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:brand/features/wishlist/presentation/viewsModel/wishlist_cubit.dart';

class FavoriteButton extends StatelessWidget {
  final String productId;
  final bool initialIsFavorite;
  final double? size;
  final EdgeInsetsGeometry? padding;

  const FavoriteButton({
    super.key,
    required this.productId,
    this.initialIsFavorite = false,
    this.size,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, state) {
        final cubit = context.read<WishlistCubit>();

        final isFavorite = cubit.isFavorite(productId, initialIsFavorite);

        return InkWell(
          customBorder: const CircleBorder(),
          onTap: () {
            cubit.toggleWishlist(productId);
          },
          child: Padding(
            padding: padding ?? EdgeInsets.all(6.0.r),
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              size: size ?? 18.sp,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
          ),
        );
      },
    );
  }
}
