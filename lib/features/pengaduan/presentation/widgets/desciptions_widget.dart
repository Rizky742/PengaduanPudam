import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pengaduan/theme.dart';


class DescriptionsWidget extends StatelessWidget {
  const DescriptionsWidget({
    super.key,
    required this.nomor,
    required this.nama,
    required this.alamat,
    required this.status,
    required this.jenisAduan,
    required this.keterangan,
  });

  final String nomor;
  final String nama;
  final String alamat;
  final String jenisAduan;
  final String keterangan;
  final String status;

  @override
  Widget build(BuildContext context) {
    // String statusText;
    // Color statusColor;
    // Color statusBackground;
    // switch (status) {
    //   case Menu.menungguPenugasan:
    //     statusText = 'Menunggu Penugasan';
    //     statusColor = pastelRed;
    //     statusBackground = lavenderBlush;
    //     break;
    //   case Menu.ditugasi:
    //     statusText = 'Ditugasi';
    //     statusColor = blueCola;
    //     statusBackground = lavenderWeb;
    //     break;
    // }
    Color statusColor;
    Color statusBackground;
    String statusText;
    switch (status) {
      case 'Belum Ditugaskan':
        statusColor = pastelRed;
        statusText = 'Belum Ditugaskan';
        statusBackground = lavenderBlush;
        break;
      case 'Ditugaskan':
        statusColor = blueCola;
        statusBackground = lavenderWeb;
        statusText = 'Ditugaskan';
      case 'Belum Diselesaikan':
        statusColor = beer;
        statusBackground = cosmicLatte;
        statusText = 'Belum Diselesaikan';
      default:
        statusColor = caribbeanGreen;
        statusBackground = bubbles;
        statusText = 'Diselesaikan';
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nomor Pelanggan',
                style: caption1.copyWith(color: graniteGray),
              ),
              Text(
                nomor.isNotEmpty ? nomor : 'Non Pelanggan' ,
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
                nama,
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
                  alamat,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  style: heading4.copyWith(color: vampireBlack),
                ),
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
                'Jenis Aduan',
                style: caption1.copyWith(color: graniteGray),
              ),
              Text(
                jenisAduan,
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
                  'Keterangan',
                  style: caption1.copyWith(color: graniteGray),
                ),
              ),
              SizedBox(
                width: 100.w,
              ),
              Expanded(
                flex: 2,
                child: Text(
                  textDirection: TextDirection.rtl,
                  keterangan,
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  style: heading4.copyWith(color: vampireBlack),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          SizedBox(
            height: 16.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Status',
                style: caption1.copyWith(color: graniteGray),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.w),
                decoration: BoxDecoration(
                  color: statusBackground,
                  border: Border.all(width: 0.5.w, color: statusColor),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  statusText,
                  style: caption2.copyWith(color: statusColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
