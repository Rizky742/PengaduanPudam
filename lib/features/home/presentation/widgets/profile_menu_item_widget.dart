import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pengaduan/theme.dart';

class ProfileMenuItemWidget extends StatelessWidget {
  const ProfileMenuItemWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.function,
  });

  final String icon;
  final String title;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 24,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(icon),
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  title,
                  style: caption1.copyWith(
                    color: graniteGray,
                  ),
                ),
              ],
            ),
            SvgPicture.asset('assets/arrow_right_icon.svg'),
          ],
        ),
      ),
    );
  }
}
