import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pengaduan/features/pengaduan/presentation/pages/pengaduan_screen.dart';
import 'package:pengaduan/features/pengaduan/presentation/widgets/container_big_widget.dart';
import 'package:pengaduan/features/pengaduan/presentation/widgets/custom_button_widget.dart';
import 'package:pengaduan/features/pengaduan/presentation/widgets/header_widget.dart';
import 'package:pengaduan/theme.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class AduanSelesaiScreen extends StatefulWidget {
  const AduanSelesaiScreen(
      {super.key,
      required this.nomorAduan,
      required this.noPelanggan,
      required this.nama,
      required this.alamat,
      required this.ditugaskanKepada,
      required this.ditugaskanOleh,
      required this.tanggalPenugasan,
      required this.tanggalPenyelesaian,
      required this.jenisPenyelesaian,
      required this.buktiPenyelesaian});

  final String nomorAduan;
  final String noPelanggan;
  final String nama;
  final String alamat;
  final String ditugaskanKepada;
  final String ditugaskanOleh;
  final String tanggalPenugasan;
  final String tanggalPenyelesaian;
  final String buktiPenyelesaian;
  final String jenisPenyelesaian;

  @override
  State<AduanSelesaiScreen> createState() => _AduanSelesaiScreenState();
}

class _AduanSelesaiScreenState extends State<AduanSelesaiScreen> {
  ScreenshotController screenshotController = ScreenshotController();
  Future<void> _shareScreenshot() async {
    final directory = await getApplicationDocumentsDirectory();

    // Menangkap screenshot
    final imageFile = await screenshotController.captureAndSave(directory.path,
        fileName: 'bukti_penyelesaian.png');

    if (imageFile != null) {
      await Share.shareXFiles([XFile(imageFile)]);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal mengambil screenshot')),
      );
    }
  }


    Future<void> _downloadScreenshot() async {
      // Capture screenshot
      final Uint8List? imageBytes = await screenshotController.capture();

      if (imageBytes != null) {
        // Save the screenshot to the gallery
        final result = await ImageGallerySaver.saveImage(
          imageBytes,
          quality: 100,
          name: 'bukti_penyelesaian', // Nama file
        );

        // Check if saving was successful
        if (result['isSuccess'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Screenshot berhasil disimpan ke galeri')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Gagal menyimpan screenshot ke galeri')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal mengambil screenshot')),
        );
      }
  
  }

  @override
  Widget build(BuildContext context) {
    var safeAreaPadding = MediaQuery.of(context).padding;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 127.h + safeAreaPadding.top,
              color: blueCola,
            ),
            Container(
              padding: EdgeInsets.only(
                  top: safeAreaPadding.top + 42.h, left: 16.w, right: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderWidget(
                    title: 'Aduan Selesai',
                    rightIcon: true,
                    jumpToPage: PengaduanScreen(),
                    // jumpToPage: 0,
                  ),
                  SizedBox(height: 28.h),
                  ContainerBigWidget(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/success_with_background_icon.svg',
                          width: 32.w,
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Text(
                          'Bukti Peyelesaian',
                          style: body1.copyWith(color: vampireBlack),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Screenshot(
                    controller: screenshotController,
                    child: ContainerBigWidget(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 16.w),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Nomor Aduan',
                                style: caption1.copyWith(color: graniteGray),
                              ),
                              Text(
                                widget.nomorAduan,
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
                                widget.noPelanggan.isNotEmpty
                                    ? widget.noPelanggan
                                    : 'Non Pelanggan',
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
                                widget.nama,
                                style: heading4.copyWith(color: vampireBlack),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Align text to the top
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
                                  widget.alamat,
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
                                widget.ditugaskanKepada,
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
                                widget.ditugaskanOleh,
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
                                widget.tanggalPenugasan,
                                style: heading4.copyWith(color: vampireBlack),
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
                                'Penyelesaian',
                                style: caption1.copyWith(color: graniteGray),
                              ),
                              Text(
                                widget.jenisPenyelesaian,
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
                                'Tanggal Penyelesaian',
                                style: caption1.copyWith(color: graniteGray),
                              ),
                              Text(
                                widget.tanggalPenyelesaian,
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
                                'Status',
                                style: caption1.copyWith(color: graniteGray),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 4.w),
                                decoration: BoxDecoration(
                                  color: bubbles,
                                  border: Border.all(
                                      width: 0.5.w, color: caribbeanGreen),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Text(
                                  "Diselesaikan",
                                  style:
                                      caption2.copyWith(color: caribbeanGreen),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Align text to the top
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Bukti Penyelesaian',
                                  style: caption1.copyWith(color: graniteGray),
                                ),
                              ),
                              // Expanded(
                              //   flex: 1,
                              //     child:
                              //         Image.network(widget.buktiPenyelesaian)),
                              // Expanded(
                              //   flex: 1,
                              //   child: Text(
                              //     textDirection: TextDirection.rtl,
                              //     widget.buktiPenyelesaian,
                              //     softWrap: true,
                              //     overflow: TextOverflow.visible,
                              //     style: heading4.copyWith(color: vampireBlack),
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Image.network(
                            widget.buktiPenyelesaian,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      CustomButton(
                        title: "Share",
                        icon: "assets/share_icon.svg",
                        onTap: _shareScreenshot,
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      CustomButton(
                        title: "Download",
                        icon: "assets/download_icon.svg",
                        onTap: _downloadScreenshot,
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      CustomButton(
                        title: "Cetak",
                        icon: "assets/printer_icon.svg",
                        onTap: () {},
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 26.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
