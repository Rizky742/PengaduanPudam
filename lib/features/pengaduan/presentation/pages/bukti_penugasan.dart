import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pengaduan/features/pengaduan/presentation/pages/pengaduan_screen.dart';
import 'package:pengaduan/features/pengaduan/presentation/widgets/bukti_information_widget.dart';
import 'package:pengaduan/features/pengaduan/presentation/widgets/custom_button_widget.dart';
import 'package:pengaduan/features/pengaduan/presentation/widgets/header_widget.dart';
import 'package:pengaduan/theme.dart';

class BuktiPenugasan extends StatelessWidget {
  const BuktiPenugasan({
    super.key,
  });
  

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
                  const BuktiInformation(),
                  SizedBox(height: 20.h),
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
                    ],
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
