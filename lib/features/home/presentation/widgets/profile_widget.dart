import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pengaduan/theme.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
    required this.divisi,
    required this.name,
    required this.profilePic,
  });

  final String name;
  final String divisi;
  final String profilePic;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20.r,
          backgroundImage: AssetImage(profilePic),
        ),
        SizedBox(
          width: 12.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: heading3.copyWith(color: white),
            ),
            Text(
              divisi,
              style: caption1.copyWith(color: white),
            ),
          ],
        ),
      ],
    );
  }
}
