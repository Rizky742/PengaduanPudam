import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContainerBigWidget extends StatelessWidget {
  const ContainerBigWidget(
      {super.key,
      required this.child,
      required this.padding,
      this.isExpanded = true});
  final Widget child;
  final EdgeInsetsGeometry padding;
  final bool isExpanded;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: isExpanded ? double.infinity : double.minPositive,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 24,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
