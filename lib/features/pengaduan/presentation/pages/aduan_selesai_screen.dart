import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pengaduan/features/pengaduan/presentation/pages/pengaduan_screen.dart';
import 'package:pengaduan/features/pengaduan/presentation/widgets/container_big_widget.dart';
import 'package:pengaduan/features/pengaduan/presentation/widgets/custom_button_widget.dart';
import 'package:pengaduan/features/pengaduan/presentation/widgets/header_widget.dart';
import 'package:pengaduan/theme.dart';

class AduanSelesaiScreen extends StatelessWidget {
  const AduanSelesaiScreen({super.key});

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
                  ContainerBigWidget(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
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
                              "02 Januari 2024",
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
                              "02 Januari 2024",
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
                                'Bukti Penyelesaian',
                                style: caption1.copyWith(color: graniteGray),
                              ),
                            ),
                            SizedBox(
                              width: 120.w,
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                textDirection: TextDirection.rtl,
                                'www.selesai.com/dqerwqrwqk/23/4',
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
                                style: caption2.copyWith(color: caribbeanGreen),
                              ),
                            ),
                          ],
                        ),
                      ],
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
                        onTap: () {},
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      CustomButton(
                        title: "Download",
                        icon: "assets/download_icon.svg",
                        onTap: () {},
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
