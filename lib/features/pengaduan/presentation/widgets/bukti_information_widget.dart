import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pengaduan/theme.dart';

class BuktiInformation extends StatelessWidget {
  const BuktiInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 24,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Center(
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/document_icon.svg',
                  width: 32.w,
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  'Bukti Penugasan',
                  style: body1.copyWith(color: vampireBlack),
                )
              ],
            ),
          ),
          SizedBox(
            height: 28.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nomor Aduan',
                style: caption1.copyWith(color: graniteGray),
              ),
              Text(
                '456456546474',
                style: heading4.copyWith(color: vampireBlack),
              ),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nomor Pelanggan',
                style: caption1.copyWith(color: graniteGray),
              ),
              Text(
                "05464564",
                style: heading4.copyWith(color: vampireBlack),
              ),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nama Pelanggan',
                style: caption1.copyWith(color: graniteGray),
              ),
              Text(
                "Jefri Nichol",
                style: heading4.copyWith(color: vampireBlack),
              ),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          Row(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align text to the top
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  'Alamat',
                  style: caption1.copyWith(color: graniteGray),
                ),
              ),
              SizedBox(
                width: 120.w,
              ),
              Expanded(
                flex: 2,
                child: Text(
                  textDirection: TextDirection.rtl,
                  'Jl. Dimembe,  No. 2, Sulawesi Utara, Manado',
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  style: heading4.copyWith(color: vampireBlack),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          const Divider(),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ditugaskan Kepada',
                style: caption1.copyWith(color: graniteGray),
              ),
              Text(
                "John F. Kenedy",
                style: heading4.copyWith(color: vampireBlack),
              ),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ditugaskan Oleh',
                style: caption1.copyWith(color: graniteGray),
              ),
              Text(
                "Joe Starry Biden",
                style: heading4.copyWith(color: vampireBlack),
              ),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tanggal Penugasan',
                style: caption1.copyWith(color: graniteGray),
              ),
              Text(
                "02 Januari 2024",
                style: heading4.copyWith(color: vampireBlack),
              ),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
        ],
      ),
    );
  }
}
