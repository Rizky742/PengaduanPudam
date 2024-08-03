import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:pengaduan/features/pengaduan/presentation/pages/aduan_selesai_screen.dart';
import 'package:pengaduan/features/pengaduan/presentation/widgets/custom_button_bottom.dart';
import 'package:pengaduan/features/pengaduan/presentation/widgets/desciptions_widget.dart';
import 'package:pengaduan/features/pengaduan/presentation/widgets/header_widget.dart';
import 'package:pengaduan/features/pengaduan/presentation/widgets/invoice_widget.dart';
import 'package:pengaduan/theme.dart';

class PenyelesaianScreen extends StatelessWidget {
  const PenyelesaianScreen({
    super.key,
    required this.noAduan,
    required this.idAduan,
    this.noPelanggan,
    required this.nama,
    required this.alamat,
    required this.jenisAduan,
    required this.keterangan,
    required this.status,
  });
  final String? noPelanggan;
  final String noAduan;
  final String idAduan;
  final String nama;
  final String alamat;
  final String jenisAduan;
  final String keterangan;
  final String status;

  @override
  Widget build(BuildContext context) {
    TextEditingController catatanController = TextEditingController();
    final List<String> items = ['Spuy'];
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
                  top: safeAreaPadding.top + 42.h, left: 16.w, right: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderWidget(
                    title: 'Penyelesaian',
                  ),
                  SizedBox(height: 28.h),
                  InvoiceWidget(
                    invoice: noAduan,
                  ),
                  SizedBox(height: 20.h),
                  DescriptionsWidget(
                    jenisAduan: jenisAduan,
                    keterangan: keterangan,
                    status: status,
                    nama: nama,
                    nomor: noPelanggan ?? 'null',
                    alamat: alamat,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Opsi Penyelesaian',
                    style: caption1.copyWith(color: vampireBlack),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          spreadRadius: 0,
                          blurRadius: 24,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        style: caption1.copyWith(color: vampireBlack),
                        icon: SvgPicture.asset(
                          'assets/arrow_bottom_icon.svg',
                          width: 16.w,
                        ),
                        isExpanded: true,
                        hint: const Text('Pilih Opsi Penyelesaian'),
                        value: 'Spuy',
                        items: items.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Catatan Penyelesaian',
                    style: caption1.copyWith(color: vampireBlack),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          spreadRadius: 0,
                          blurRadius: 24,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      style: caption1.copyWith(color: vampireBlack),
                      maxLines: 5,
                      controller: catatanController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(12.w),
                        hintText: 'Ketik Catatan Penyelesaian Tugas....',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  CustomButtonBottom(
                    title: "Kirim",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AduanSelesaiScreen(),
                          ));
                    },
                  ),
                  SizedBox(
                    height: 32.h,
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
