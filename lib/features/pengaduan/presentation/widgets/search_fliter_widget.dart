import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pengaduan/features/pengaduan/presentation/bloc/pengaduan_bloc.dart';
import 'package:pengaduan/theme.dart';

// ignore: must_be_immutable
class SearchFliterWidget extends StatelessWidget {
  SearchFliterWidget({
    super.key,
    required this.controller,
    required this.filter,
  });

  TextEditingController controller;
  String filter;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 24,
                  offset: const Offset(0, 4),
                ),
              ],
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: TextField(
              controller: controller,
              onChanged: (value) {
                context.read<PengaduanBloc>().add(GetFilterPengaduanEvent());
              },
              style: body2,
              decoration: InputDecoration(
                hintText: 'Cari Nama / Nomor Pelanggan',
                hintStyle: caption1,
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 24,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: PopupMenuButton<String>(
            icon: SvgPicture.asset(
              'assets/filter_icon.svg',
            ),
            onSelected: (String value) {
              filter = value;
              context.read<PengaduanBloc>().add(GetFilterPengaduanEvent());
            },
            color: white,
            shadowColor: Colors.black,
            position: PopupMenuPosition.under,
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r)),
            popUpAnimationStyle: AnimationStyle(curve: Curves.linearToEaseOut),
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: '',
                  child: Text('Semua'),
                ),
                const PopupMenuItem<String>(
                  value: 'Belum Ditugaskan',
                  child: Text('Belum Ditugaskan'),
                ),
                const PopupMenuItem<String>(
                  value: 'Ditugaskan',
                  child: Text('Ditugaskan'),
                ),
                const PopupMenuItem<String>(
                  value: 'Belum Diselesaikan',
                  child: Text('Belum Diselesaikan'),
                ),
                const PopupMenuItem<String>(
                  value: 'Diselesaikan',
                  child: Text('Diselesaikan'),
                ),
              ];
            },
          ),
        ),
      ],
    );
  }
}
