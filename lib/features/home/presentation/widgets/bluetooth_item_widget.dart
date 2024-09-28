import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pengaduan/theme.dart';

enum Status { connected, disconnected }

class BluetoothItemWidget extends StatelessWidget {
  const BluetoothItemWidget({
    super.key,
    required this.title,
    required this.status,
  });

  final String title;
  final Status status;

  @override
  Widget build(BuildContext context) {
    String statusText;
    Color statusColor;
    switch (status) {
      case Status.connected:
        statusText = 'Connected - Ready to Printing';
        statusColor = blueCola;
        break;
      case Status.disconnected:
        statusText = 'Disconnected';
        statusColor = graniteGray;
        break;
    }
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: brightGray),
            borderRadius: BorderRadius.circular(8.r),
            color: white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: heading3.copyWith(color: vampireBlack),
                ),
                Text(
                  statusText,
                  style: caption1.copyWith(color: statusColor),
                ),
              ],
            ),
            SvgPicture.asset(
              'assets/option_icon.svg',
              width: 20.w,
            ),
          ],
        ),
      ),
    );
  }
}
