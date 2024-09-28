import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/penugas.dart';
import 'package:pengaduan/features/pengaduan/presentation/pages/pengaduan_screen.dart';
import 'package:pengaduan/features/pengaduan/presentation/widgets/bukti_information_widget.dart';
import 'package:pengaduan/features/pengaduan/presentation/widgets/custom_button_widget.dart';
import 'package:pengaduan/features/pengaduan/presentation/widgets/header_widget.dart';
import 'package:pengaduan/theme.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class BuktiPenugasan extends StatefulWidget {
  const BuktiPenugasan({
    required this.penugasan,
    super.key,
    required this.ditugaskanOleh,
  });
  final Penugasan penugasan;
  final String ditugaskanOleh;

  @override
  State<BuktiPenugasan> createState() => _BuktiPenugasanState();
}

class _BuktiPenugasanState extends State<BuktiPenugasan> {
  // Controller untuk menangkap screenshot
  ScreenshotController screenshotController = ScreenshotController();

  Future<void> _shareScreenshot() async {
    final directory = await getApplicationDocumentsDirectory();

    // Menangkap screenshot
    final imageFile = await screenshotController.captureAndSave(directory.path,
        fileName: 'bukti_penugasan.png');

    if (imageFile != null) {
      final message =
          'Laporan ditugaskan kepada ${widget.penugasan.petugas}, mohon segera ditindaklanjuti.\n\n'
          'Berikut adalah rincian penugasannya:\n'
          '- Nomor Pelanggan: ${widget.penugasan.noPelanggan}\n'
          '- Jenis Laporan: ${widget.penugasan.jenisLaporan}\n'
          '- Keterangan: ${widget.penugasan.keterangan}\n'
          '- Target Penyelesaian: ${widget.penugasan.targetPenyelesaian}\n'
          '- Alamat: ${widget.penugasan.alamat}\n'
          '- Ditugaskan Oleh: ${widget.ditugaskanOleh}\n'
          '- Nama: ${widget.penugasan.nama}\n'
          '- Nomor Pengaduan: ${widget.penugasan.noAduan}\n'
          '- Tanggal: ${widget.penugasan.tanggal}\n\n'
          'Lihat lampiran untuk informasi lebih lanjut dan segera tindak lanjuti laporan ini.\n\n'
          'Terima kasih.';
      // Share the image
      await Share.shareXFiles([XFile(imageFile)], text: message);
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
              height: 135.h + safeAreaPadding.top,
              color: blueCola,
            ),
            Container(
              padding: EdgeInsets.only(
                top: safeAreaPadding.top + 42.h,
                left: 16.w,
                right: 16.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderWidget(
                    title: 'Penugasan',
                    jumpToPage: PengaduanScreen(),
                  ),
                  SizedBox(height: 28.h),
                  Screenshot(
                    controller: screenshotController,
                    child: BuktiInformation(
                      noPelanggan: widget.penugasan.noPelanggan,
                      jenisLaporan: widget.penugasan.jenisLaporan,
                      keterangan: widget.penugasan.keterangan,
                      targetPenyelesaian: widget.penugasan.targetPenyelesaian,
                      alamat: widget.penugasan.alamat,
                      ditugaskanKepada: widget.penugasan.petugas,
                      ditugaskanOleh: widget.ditugaskanOleh,
                      nama: widget.penugasan.nama,
                      nomorPengaduan: widget.penugasan.noAduan,
                      tanggal: widget.penugasan.tanggal,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      CustomButton(
                        title: "Share",
                        icon: "assets/share_icon.svg",
                        onTap:
                            _shareScreenshot, // Panggil fungsi ini untuk share
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      CustomButton(
                        title: "Download",
                        icon: "assets/download_icon.svg",
                        onTap:
                            _downloadScreenshot, // Panggil fungsi ini untuk download
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
