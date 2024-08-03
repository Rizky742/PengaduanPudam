import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pengaduan/features/pengaduan/presentation/widgets/container_big_widget.dart';
import 'package:pengaduan/theme.dart';

class InvoiceWidget extends StatelessWidget {
  const InvoiceWidget({
    super.key,
    required this.invoice,
  });

  final String invoice;
  @override
  Widget build(BuildContext context) {
    return ContainerBigWidget(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Center(
        child: Text(
          'No. Aduan : $invoice',
          style: heading3.copyWith(color: vampireBlack),
        ),
      ),
    );
  }
}
