import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pengaduan/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pengaduan/features/pengaduan/domain/entitites/petugas.dart';
import 'package:pengaduan/features/pengaduan/presentation/bloc/penugasan_bloc.dart';
import 'package:pengaduan/features/pengaduan/presentation/bloc/petugas_bloc.dart';
import 'package:pengaduan/features/pengaduan/presentation/bloc/send_penugasan_bloc.dart';
import 'package:pengaduan/features/pengaduan/presentation/helper/month_converter.dart';
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
    required this.idAduan,
    this.noPelanggan,
    required this.nama,
    required this.alamat,
    required this.jenisAduan,
    required this.keterangan,
    required this.status,
  });

  final String? noPelanggan;
  final String idAduan;
  final String noAduan;
  final String nama;
  final String alamat;
  final String jenisAduan;
  final String keterangan;
  final String status;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

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
              child: Form(
                key: formKey,
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
                      'Pilih Petugas',
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
                      child: DropdownSearch<Petugas>(
                        validator: (value) {
                          if (value == null) {
                            return 'Petugas belum terisi';
                          }
                          return null;
                        },
                        itemAsString: (item) => item.nama,
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
                                  selectedItem?.nama ??
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
                          icon:
                              SvgPicture.asset('assets/arrow_bottom_icon.svg'),
                        ),
                        popupProps: PopupProps.bottomSheet(
                          loadingBuilder: (context, searchEntry) =>
                              const Center(
                            child: CircularProgressIndicator(),
                          ),
                          showSearchBox: true,
                          bottomSheetProps: const BottomSheetProps(
                            backgroundColor: Colors.white,
                            elevation: 10,
                          ),
                          interceptCallBacks: false,
                        ),
                        asyncItems: (text) async {
                          // Trigger loading event
                          final divisiId = context.read<AuthBloc>().state;
                          String id = '';
                          if (divisiId is AuthLoggedIn) {
                            id = divisiId.auth.divisiId.toString();
                          }
                          context
                              .read<PetugasBloc>()
                              .add(GetPetugasEvent(divisiId: id));

                          // Wait for the state to change and data to be loaded
                          final state = await context
                              .read<PetugasBloc>()
                              .stream
                              .firstWhere((state) => state is PetugasLoaded);

                          // Return the data to the dropdown
                          if (state is PetugasLoaded) {
                            return state.petugas.map((e) => e).toList();
                          }

                          // Return an empty list or handle errors
                          return [];
                        },
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
                        onChanged: (value) {
                          context
                              .read<PenugasanBloc>()
                              .add(SelectPetugas(value!));
                        },
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
                        context
                            .read<PenugasanBloc>()
                            .add(SelectDate(day: newValue));
                      },
                      onMonthChanged: (String? newValue) {
                        context
                            .read<PenugasanBloc>()
                            .add(SelectDate(month: newValue));
                      },
                      onYearChanged: (String? newValue) {
                        context
                            .read<PenugasanBloc>()
                            .add(SelectDate(year: newValue));
                      },
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    BlocConsumer<SendPenugasanBloc, SendPenugasanState>(
                      listener: (context, state) {
                        if (state is SendPenugasanError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: pastelRed,
                              content: Text(state.message),
                            ),
                          );
                        } else if (state is SendPenugasanSuccess) {
                          // print(state.penugasan.nama);
                          final stateAuth = context.read<AuthBloc>().state;
                          if (stateAuth is AuthLoggedIn) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BuktiPenugasan(
                                  ditugaskanOleh: stateAuth.auth.nama,
                                  penugasan: state.penugasan,
                                ),
                              ),
                            );
                          }
                        }
                      },
                      builder: (context, state) {
                        if (state is SendPenugasanLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return CustomButtonBottom(
                          title: "Kirim",
                          onPressed: () {
                            final state = context.read<PenugasanBloc>().state;
                            final stateAuth = context.read<AuthBloc>().state;
                            if (state is PenugasanLoaded &&
                                stateAuth is AuthLoggedIn) {
                              if (!formKey.currentState!.validate()) return;
                              DateTime tanggal = DateTime(
                                  int.parse(state.selectedYear),
                                  convert(state.selectedMonth)!,
                                  int.parse(state.selectedDay));
                              context.read<SendPenugasanBloc>().add(
                                  ToggleSendPenugasanEvent(
                                      idKepala: stateAuth.auth.id,
                                      idPetugas: state.selectedPetugas!.id,
                                      idPengaduan: int.parse(idAduan),
                                      tglTarget: tanggal));
                            }
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
