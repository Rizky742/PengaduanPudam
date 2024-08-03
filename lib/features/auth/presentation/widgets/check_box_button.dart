import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pengaduan/theme.dart';

class CheckBoxButton extends StatelessWidget {
  const CheckBoxButton({
    super.key,
    required this.isCheckbox,
    required this.onChanged,
  });

  final bool isCheckbox;
  final Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isCheckbox,
          onChanged: onChanged,
          checkColor: blueCola,
          activeColor: lavenderWeb,
        ),
        SizedBox(
          width: 4.w,
        ),
        Text(
          "Ingat saya",
          style: caption1.copyWith(color: graniteGray),
        )
      ],
    );
  }
}
