import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pengaduan/theme.dart';

class BuktiInformation extends StatelessWidget {
  const BuktiInformation({
    super.key,
    required this.nomorPengaduan,
    required this.nama,
    required this.alamat,
    required this.ditugaskanKepada,
    required this.ditugaskanOleh,
    required this.tanggal,
    required this.targetPenyelesaian,
    required this.jenisLaporan,
    required this.keterangan,
    required this.noPelanggan,
  });
  final String nomorPengaduan;
  final String nama;
  final String alamat;
  final String noPelanggan;
  final String ditugaskanKepada;
  final String ditugaskanOleh;
  final String tanggal;
  final String jenisLaporan;
  final String keterangan;
  final String targetPenyelesaian;

  @override
  Widget build(BuildContext context) {
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
                nomorPengaduan,
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
                noPelanggan.isEmpty ? 'Non Pelanggan' : noPelanggan,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Jenis Laporan',
                style: caption1.copyWith(color: graniteGray),
              ),
              Text(
                jenisLaporan,
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
              Expanded(
                flex: 1,
                child: Text(
                  textAlign: TextAlign.right, // Use textAlign for alignment
                  textDirection: TextDirection.rtl,
                  keterangan.isNotEmpty ? keterangan : 'Tidak ada keterangan',
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
                flex: 1,
                child: Text(
                  textAlign: TextAlign.right, // Use textAlign for alignment
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
                ditugaskanKepada,
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
                ditugaskanOleh,
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
                tanggal,
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
                'Target Penyelesaian ',
                style: caption1.copyWith(color: graniteGray),
              ),
              Text(
                targetPenyelesaian,
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
