import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pengaduan/features/pengaduan/presentation/pages/penugasan_screen.dart';
import 'package:pengaduan/features/pengaduan/presentation/pages/penyelesaian_screen.dart';
import 'package:pengaduan/theme.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class PengaduanItem extends StatelessWidget {
  const PengaduanItem({
    super.key,
    required this.noAduan,
    required this.idAduan,
    required this.noPelanggan,
    required this.nama,
    required this.alamat,
    required this.status,
    required this.phoneNumber,
    required this.jenisAduan,
    required this.keterangan,
    required this.role,
  });

  final String? noPelanggan;
  final String noAduan;
  final String idAduan;
  final String nama;
  final String alamat;
  final String phoneNumber;
  final String jenisAduan;
  final String keterangan;
  final String status;
  final String role;

  Future<void> _makePhoneCall(BuildContext context, String phoneNumber) async {
    if (phoneNumber.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Pemberitahuan'),
            content: const Text('Nomor telepon tidak tersedia.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    Color mainColor;
    Color backgroundColor;
    String text;
    switch (status) {
      case 'Belum Ditugaskan':
        mainColor = pastelRed;
        text = 'Belum Ditugaskan';
        backgroundColor = lavenderBlush;
        break;
      case 'Ditugaskan':
        mainColor = blueCola;
        backgroundColor = lavenderWeb;
        text = 'Ditugaskan';
      case 'Belum Diselesaikan':
        mainColor = beer;
        backgroundColor = cosmicLatte;
        text = 'Belum Diselesaikan';
      default:
        mainColor = caribbeanGreen;
        backgroundColor = bubbles;
        text = 'Diselesaikan';
    }
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PenyelesaianScreen(
              idAduan: idAduan,
              status: status,
              jenisAduan: jenisAduan,
              keterangan: keterangan,
              alamat: alamat,
              nama: nama,
              noAduan: noAduan,
              noPelanggan: noPelanggan,
            ),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: IntrinsicHeight(
          child: Container(
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
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/sudah_ditugasi_icon.svg',
                  width: 24.w,
                ),
                SizedBox(
                  width: 8.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          border: Border.all(
                            width: 0.5.w,
                            color: mainColor,
                          ),
                          borderRadius: BorderRadiusDirectional.circular(100),
                        ),
                        child: Text(
                          text,
                          style: caption2.copyWith(color: mainColor),
                        ),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              noAduan.toString(),
                              style: heading3.copyWith(
                                color: blueCola,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        noPelanggan!.isEmpty
                            ? 'non pelanggan - $nama'
                            : '$noPelanggan - $nama',
                        style: caption1.copyWith(color: graniteGray),
                      ),
                      Text(
                        jenisAduan,
                        style: caption2.copyWith(color: graniteGray),
                      ),
                      Text(
                        alamat.toString(),
                        style: caption2.copyWith(color: graniteGray),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () => _makePhoneCall(context, phoneNumber),
                          child: SvgPicture.asset(
                            'assets/phone_icon.svg',
                            width: 17.w,
                          ),
                        ),
                        SizedBox(
                          width: 12.h,
                        ),
                        PopupMenuButton<String>(
                          icon: SvgPicture.asset(
                            'assets/option_icon.svg',
                            width: 17.w,
                          ),
                          color: Colors.white,
                          shadowColor: Colors.black,
                          elevation: 5,
                          position: PopupMenuPosition.under,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r)),
                          popUpAnimationStyle:
                              AnimationStyle(curve: Curves.linearToEaseOut),
                          onSelected: (value) {
                            if (value == 'penugasan') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PenugasanScreen(
                                      status: status,
                                      alamat: alamat,
                                      jenisAduan: jenisAduan,
                                      keterangan: keterangan,
                                      nama: nama,
                                      noAduan: noAduan,
                                      noPelanggan: noPelanggan,
                                    ),
                                  ));
                            }
                          },
                          itemBuilder: (context) {
                            List<PopupMenuEntry<String>> menu = [
                              const PopupMenuItem<String>(
                                value: 'cetak_bpk',
                                child: Text('Cetak BPK'),
                              ),
                              const PopupMenuItem<String>(
                                value: 'cetak_spk',
                                child: Text('Cetak SPK'),
                              ),
                            ];
                            if (status.toLowerCase() == 'ditugaskan' && role.toLowerCase() == 'kepala') {
                              menu.add(
                                const PopupMenuItem<String>(
                                  value: 'penugasan',
                                  child: Text('Penugasan'),
                                ),
                              );
                            }
                            return menu;
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
