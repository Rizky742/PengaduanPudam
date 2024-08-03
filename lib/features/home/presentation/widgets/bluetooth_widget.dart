import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pengaduan/theme.dart';

// ignore: must_be_immutable
class BluetoothWidget extends StatelessWidget {
  BluetoothWidget({
    super.key,
    required this.safeAreaPadding,
    required this.status,
    required this.onTap,
  });

  final EdgeInsets safeAreaPadding;
  final VoidCallback onTap;
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.all(
              Radius.circular(8.r),
            ),
            border: Border.all(
                color: status ? caribbeanGreen : pastelRed, width: 2)),
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            SvgPicture.asset(
              status ? 'assets/success_icon.svg' : 'assets/danger_icon.svg',
              width: 12.w,
            ),
            SizedBox(
              width: 8.w,
            ),
            Text(
              'Belum ada printer yang terhubung ke Bluetooth',
              style: caption2.copyWith(
                  color: status ? caribbeanGreen : pastelRed),
            ),
          ],
        ),
      ),
    );
  }
}
