import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pengaduan/theme.dart';

class CustomButtonBottom extends StatelessWidget {
  const CustomButtonBottom({
    super.key,
    required this.title,
    required this.onPressed,
  });

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Full width
      child: ElevatedButton(
        style: ButtonStyle(
          padding: WidgetStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(vertical: 14.h),
          ),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(8.w)))),
          backgroundColor: const WidgetStatePropertyAll(blueCola),
        ),
        // onPressed: () {
        //   Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => const BuktiPenugasan(),
        //       ));
        // },
        onPressed: onPressed,
        child: Text(
          title,
          style: heading4.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
