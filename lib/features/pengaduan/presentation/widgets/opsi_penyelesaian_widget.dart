import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/jenis_penyelesaian.dart';
import 'package:pengaduan/features/pengaduan/presentation/bloc/jenis_penyelesaian_bloc.dart';
import 'package:pengaduan/features/pengaduan/presentation/bloc/send_penyelesaian_bloc.dart';
import 'package:pengaduan/theme.dart';

class OpsiPenyelesaianWidget extends StatelessWidget {
  const OpsiPenyelesaianWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JenisPenyelesaianBloc, JenisPenyelesaianState>(
      bloc: context.read<JenisPenyelesaianBloc>()
        ..add(GetJenisPenyelesaianEvent()),
      builder: (context, state) {
        List<JenisPenyelesaian> items = [];
        if (state is JenisPenyelesaianLoaded) {
          items = state.jenisPenyelesaian;
        } else if (state is JenisPenyelesaianError) {
          print(state.message);
        }
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                spreadRadius: 0,
                blurRadius: 24,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField<int>(
              style: caption1.copyWith(color: vampireBlack),
              icon: SvgPicture.asset(
                'assets/arrow_bottom_icon.svg',
                width: 16.w,
              ),
              isExpanded: true,
              hint: const Text('Pilih Opsi Penyelesaian'),
              items: items.map((JenisPenyelesaian jenis) {
                return DropdownMenuItem<int>(
                  value: jenis.id, // Using jenis.id as the value
                  child: Text(jenis.nama),
                );
              }).toList(),
              onChanged: (value) {
                context.read<SendPenyelesaianBloc>().add(
                    SendPenyelesaianSetOpsiPenyelesaian(
                        penyelesaianId: value.toString()));
              },
              decoration: const InputDecoration(
                border: InputBorder.none, // This removes the underline
              ),
              validator: (value) {
                if (value == null) {
                  return 'Opsi Penyelesaian belum terisi';
                }
                return null;
              },
            ),
          ),
        );
      },
    );
  }
}
