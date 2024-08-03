import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dashboard_item.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({
    super.key,
    required this.belumDitugasi,
    required this.sudahDitugasi,
    required this.sudahDiselesaikan,
    required this.belumDiselesaikan,
  });
  final int belumDitugasi;
  final int sudahDitugasi;
  final int sudahDiselesaikan;
  final int belumDiselesaikan;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            DashboardItem(
              amount: belumDitugasi,
              type: Type.belumDitugasi,
            ),
            SizedBox(
              width: 12.w,
            ),
            DashboardItem(
              amount: sudahDitugasi,
              type: Type.sudahDitugasi,
            ),
          ],
        ),
        SizedBox(
          height: 12.h,
        ),
        Row(
          children: [
            DashboardItem(
              amount: belumDiselesaikan,
              type: Type.belumDiselesaikan,
            ),
            SizedBox(
              width: 12.w,
            ),
            DashboardItem(
              amount: sudahDiselesaikan,
              type: Type.sudahDiselesaikan,
            ),
          ],
        ),
      ],
    );
  }
}
