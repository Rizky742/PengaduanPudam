import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pengaduan/core/dialog/setUpUrl.dart';
import 'package:pengaduan/theme.dart';

class SetUpURL extends StatelessWidget {
  const SetUpURL({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController urlController = TextEditingController();
    return GestureDetector(
      onTap: () {
        setUpDialog(context, urlController);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/set_up_url_icon.svg',
            width: 24.w,
          ),
          SizedBox(
            width: 8.w,
          ),
          Text(
            'Setup URL',
            style: caption1.copyWith(color: Colors.black),
          )
        ],
      ),
    );
  }
}
