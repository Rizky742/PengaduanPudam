import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pengaduan/theme.dart';

enum Type {
  belumDitugasi,
  sudahDitugasi,
  belumDiselesaikan,
  sudahDiselesaikan,
}

class DashboardItem extends StatelessWidget {
  const DashboardItem({
    super.key,
    required this.amount,
    required this.type,
  });

  final String amount;
  final Type type;

  @override
  Widget build(BuildContext context) {
    Color color;
    String icon;
    String status;
    switch (type) {
      case Type.belumDitugasi:
        color = pastelRed;
        icon = 'assets/belum_ditugasi_icon.svg';
        status = 'Belum Ditugasi';
        break;
      case Type.sudahDitugasi:
        color = blueCola;
        icon = 'assets/sudah_ditugasi_icon.svg';
        status = 'Sudah Ditugasi';
        break;
      case Type.belumDiselesaikan:
        color = beer;
        icon = 'assets/belum_diselesaikan_icon.svg';
        status = 'Belum Diselesaikan';
        break;
      case Type.sudahDiselesaikan:
        color = caribbeanGreen;
        icon = 'assets/sudah_diselesaikan_icon.svg';
        status = 'Sudah Diselesaikan';
        break;
      default:
        color = pastelRed;
        icon = 'assets/belum_ditugasi_icon.svg';
        status = 'Belum Ditugasi';
        break;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      width: 158.w,
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: color),
          borderRadius: BorderRadius.circular(16.r),
          color: white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            icon,
            width: 32.w,
          ),
          Text(
           amount,
            style: heading1.copyWith(color: color),
            // overflow: TextOverflow.ellipsis,
          ),
          Text(
            status,
            style: caption1.copyWith(color: graniteGray),
          ),
        ],
      ),
    );
  }
}
