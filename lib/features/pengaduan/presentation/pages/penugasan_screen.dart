
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pengaduan/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pengaduan/features/pengaduan/presentation/bloc/petugas_bloc.dart';
import 'package:pengaduan/features/pengaduan/presentation/pages/bukti_penugasan.dart';
import 'package:pengaduan/features/pengaduan/presentation/widgets/custom_button_bottom.dart';
import 'package:pengaduan/features/pengaduan/presentation/widgets/date_widget.dart';
import 'package:pengaduan/features/pengaduan/presentation/widgets/desciptions_widget.dart';
import 'package:pengaduan/features/pengaduan/presentation/widgets/header_widget.dart';
import 'package:pengaduan/features/pengaduan/presentation/widgets/invoice_widget.dart';
import 'package:pengaduan/theme.dart';

class PenugasanScreen extends StatelessWidget {
  const PenugasanScreen({
    super.key,
    required this.noAduan,
    this.noPelanggan,
    required this.nama,
    required this.alamat,
    required this.jenisAduan,
    required this.keterangan,
    required this.status,
  });

  final String? noPelanggan;
  final String noAduan;
  final String nama;
  final String alamat;
  final String jenisAduan;
  final String keterangan;
  final String status;

  @override
  Widget build(BuildContext context) {
    // final List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
    // final controller = ref.watch(petugasController);

    // final selectedDay = ref.watch(dayProvider);
    // final selectedMonth = ref.watch(monthProvider);
    // final selectedYear = ref.watch(yearProvider);
    // const  String selectedDay = '';
    // const String selectedMonth = '';
    // const  String selectedYear = '';
    var safeAreaPadding = MediaQuery.of(context).padding;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 135.h + safeAreaPadding.top,
              color: blueCola,
            ),
            Container(
              padding: EdgeInsets.only(
                  top: safeAreaPadding.top + 42.h, left: 16.w, right: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderWidget(
                    title: 'Penugasan',
                  ),
                  SizedBox(height: 28.h),
                  InvoiceWidget(
                    invoice: noAduan,
                  ),
                  SizedBox(height: 20.h),
                  DescriptionsWidget(
                    status: status,
                    nama: nama,
                    nomor: noPelanggan ?? '',
                    alamat: alamat,
                    jenisAduan: jenisAduan,
                    keterangan: keterangan,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Pilih Tanggal Target Penyelesaian',
                    style: caption1.copyWith(color: vampireBlack),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 24,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: DropdownSearch<String>(
                      dropdownBuilder: (context, selectedItem) {
                        return Row(
                          children: [
                            SvgPicture.asset(
                              'assets/person_icon.svg',
                              width: 24.w,
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            Expanded(
                              child: Text(
                                selectedItem ??
                                    'Pilih Petugas yang akan ditugaskan',
                                style: caption1.copyWith(
                                    color: selectedItem != null
                                        ? vampireBlack
                                        : spanishGray),
                              ),
                            ),
                          ],
                        );
                      },
                      dropdownButtonProps: DropdownButtonProps(
                        icon: SvgPicture.asset('assets/arrow_bottom_icon.svg'),
                      ),

                      popupProps: const PopupProps.bottomSheet(
                        showSearchBox: true,
                        bottomSheetProps: BottomSheetProps(
                          backgroundColor: Colors.white,
                          elevation: 10,
                        ),
                        interceptCallBacks: false,
                      
                        // autoCloseSearchBox: true,

                        // title: Text('Cari Petugas', style: heading2.copyWith(color: vampireBlack), textAlign: TextAlign.center,),
                        // showSelectedItems: true,
                        // disabledItemFn: (String s) => s.startsWith('I'),
                      ),
                      asyncItems: (text) {
                        Future<List<String>> getPetugas() async {
                          final divisiId = context.read<AuthBloc>().state;
                          String id = '';
                          if (divisiId is AuthLoggedIn) {
                            id = divisiId.auth.divisiId.toString();
                          }
                          context
                              .read<PetugasBloc>()
                              .add(GetPetugasEvent(divisiId: id));
                          final data = context.read<PetugasBloc>().state;
                          if (data is PetugasLoaded) {
                            return data.petugas
                                .map(
                                  (e) => e.nama,
                                )
                                .toList();
                          }
                          return [''];
                        }

                        return getPetugas();
                      },
                      // items: const [
                      //   "Brazil",
                      //   "Italia",
                      //   "Tunisia",
                      //   'Canada',
                      //   "Brazil",
                      //   "Italia (Disabled)",
                      //   "Tunisia",
                      //   'Canada',
                      // ],
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          filled: true,
                          fillColor: white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      onChanged: print,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Pilih Tanggal Target Penyelesaian',
                    style: caption1.copyWith(color: vampireBlack),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 12.h),
                  DateWidget(
                    selectedDay: null,
                    selectedMonth: null,
                    selectedYear: null,
                    onDayChanged: (String? newValue) {
                      // ref.read(dayProvider.notifier).state = newValue!;
                    },
                    onMonthChanged: (String? newValue) {
                      // ref.read(monthProvider.notifier).state = newValue!;
                    },
                    onYearChanged: (String? newValue) {
                      // ref.read(yearProvider.notifier).state = newValue!;
                    },
                  ),
                  // const Spacer(),
                  SizedBox(
                    height: 40.h,
                  ),
                  CustomButtonBottom(
                    title: "Kirim",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BuktiPenugasan(),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
