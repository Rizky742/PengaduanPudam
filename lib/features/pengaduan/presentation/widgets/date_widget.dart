import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pengaduan/theme.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({
    super.key,
    required this.selectedDay,
    required this.selectedMonth,
    required this.selectedYear,
    required this.onDayChanged,
    required this.onMonthChanged,
    required this.onYearChanged,
  });

  final String? selectedDay;
  final String? selectedMonth;
  final String? selectedYear;
  final ValueChanged<String?> onDayChanged;
  final ValueChanged<String?> onMonthChanged;
  final ValueChanged<String?> onYearChanged;

  @override
  Widget build(BuildContext context) {
    final List<String> months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    final int currentYear = DateTime.now().year;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                blurRadius: 24,
                offset: const Offset(0, 4),
                color: Colors.black.withOpacity(0.04),
              )
            ]),
            child: DropdownButtonFormField<String>(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Tanggal belum terisi';
                }
                return null;
              },
              icon: SvgPicture.asset('assets/arrow_bottom_icon.svg'),
              style: caption1.copyWith(color: vampireBlack),
              dropdownColor: white,
              focusColor: white,
              hint: Text(
                'Tanggal',
                style: caption1.copyWith(color: spanishGray),
              ),
              value: selectedDay,
              onChanged: onDayChanged,
              items: List.generate(31, (index) {
                return DropdownMenuItem(
                  value: (index + 1).toString(),
                  child: Text((index + 1).toString()),
                );
              }),
              decoration: InputDecoration(
                filled: true,
                contentPadding: EdgeInsets.all(12.w),
                alignLabelWithHint: false,
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                fillColor: white,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                blurRadius: 24,
                offset: const Offset(0, 4),
                color: Colors.black.withOpacity(0.04),
              )
            ]),
            child: DropdownButtonFormField<String>(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Bulan belum terisi';
                }
                return null;
              },
              icon: SvgPicture.asset('assets/arrow_bottom_icon.svg'),
              borderRadius: BorderRadius.circular(8.r),
              dropdownColor: white,
              focusColor: white,
              isExpanded: true,
              hint: Text(
                'Bulan',
                style: caption1.copyWith(color: spanishGray),
              ),
              style: caption1.copyWith(color: vampireBlack),
              value: selectedMonth,
              onChanged: onMonthChanged,
              items: months.map((month) {
                return DropdownMenuItem(
                  value: month,
                  child: Text(
                    month,
                    overflow: TextOverflow.visible,
                  ),
                );
              }).toList(),
              decoration: InputDecoration(
                filled: true,
                contentPadding: EdgeInsets.all(12.w),
                alignLabelWithHint: false,
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                fillColor: white,
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          flex: 1,
          child: DropdownButtonFormField<String>(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Tahun belum terisi';
              }
              return null;
            },
            style: caption1.copyWith(color: vampireBlack),
            dropdownColor: white,
            focusColor: white,
            icon: SvgPicture.asset('assets/arrow_bottom_icon.svg'),
            isExpanded: false,
            hint: Text(
              'Tahun',
              style: caption1.copyWith(color: spanishGray),
            ),
            value: selectedYear,
            onChanged: onYearChanged,
            items: List.generate(10, (index) {
              return DropdownMenuItem(
                value: (currentYear + index).toString(),
                child: Text((currentYear + index).toString()),
              );
            }),
            decoration: InputDecoration(
              filled: true,
              contentPadding: EdgeInsets.all(12.w),
              alignLabelWithHint: false,
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12.0),
              ),
              fillColor: white,
            ),
          ),
        ),
      ],
    );
  }
}
