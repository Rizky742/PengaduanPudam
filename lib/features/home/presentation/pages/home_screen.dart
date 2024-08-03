import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:pengaduan/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pengaduan/features/home/presentation/bloc/dashboard_bloc.dart';
import 'package:pengaduan/features/home/presentation/bloc/periode_bloc.dart';
import 'package:pengaduan/features/home/presentation/pages/bluetooth_screen.dart';
import 'package:pengaduan/features/home/presentation/widgets/bluetooth_widget.dart';
import 'package:pengaduan/features/home/presentation/widgets/dashboard_widget.dart';
import 'package:pengaduan/features/home/presentation/widgets/profile_widget.dart';
import 'package:pengaduan/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var safeAreaPadding = MediaQuery.of(context).padding;
    final periodeState = context.read<PeriodeBloc>().state;
    if (periodeState is PeriodeSetted) {
      context.read<DashboardBloc>().add(GetDashboardEvent(
          '${periodeState.periode.month}', '${periodeState.periode.year}'));
    } else {
      DateTime now = DateTime.now();
      final int year = now.year;
      final int month = now.month;
      context.read<DashboardBloc>().add(GetDashboardEvent('$month', '$year'));
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 187.h + safeAreaPadding.top,
              color: blueCola,
            ),
            Container(
              padding: EdgeInsets.only(
                  top: 43.h + safeAreaPadding.top, left: 16.w, right: 16.w),
              child: Column(
                children: [
                  BluetoothWidget(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BluetoothScreen(),
                        ),
                      );
                    },
                    safeAreaPadding: safeAreaPadding,
                    status: false,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoggedIn) {
                        final auth = state.auth;
                        return ProfileWidget(
                          profilePic: 'assets/profil.png',
                          name: auth.nama,
                          divisi: '${auth.namaDivisi} | ${auth.role}',
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12.r)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 24,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        DateTime pilihTanggal = DateTime.now();
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) => Container(
                            width: double.infinity,
                            height: 250.h,
                            color: Colors.white,
                            child: CupertinoDatePicker(
                              initialDateTime: DateTime.now(),
                              mode: CupertinoDatePickerMode.monthYear,
                              onDateTimeChanged: (value) {
                                pilihTanggal = value;
                              },
                            ),
                          ),
                        ).then(
                          (value) {
                            context.read<DashboardBloc>().add(GetDashboardEvent(
                                pilihTanggal.month.toString(),
                                pilihTanggal.year.toString()));
                            context
                                .read<PeriodeBloc>()
                                .add(PeriodeSet(pilihTanggal));
                          },
                        );
                      },
                      child: BlocBuilder<PeriodeBloc, PeriodeState>(
                        builder: (context, state) {
                          String periode = '';
                          if (state is PeriodeSetted) {
                            periode =
                                DateFormat('MMMM yyyy').format(state.periode);
                          }
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                periode.isEmpty
                                    ? 'Periode Pemeliharaan'
                                    : periode,
                                style: periode.isEmpty ?  caption1.copyWith(color: spanishGray) : caption1.copyWith(color: vampireBlack),
                              ),
                              SvgPicture.asset('assets/arrow_bottom_icon.svg'),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  BlocBuilder<DashboardBloc, DashboardState>(
                    builder: (context, state) {
                      if (state is DashboardLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is DashboardLoaded) {
                        return Dashboard(
                          belumDitugasi: state.dashboard.belumDitugaskan,
                          sudahDitugasi: state.dashboard.ditugaskan,
                          belumDiselesaikan: state.dashboard.belumDiselesaikan,
                          sudahDiselesaikan: state.dashboard.diselesaikan,
                        );
                      }  else if (state is DashboardError) {
                        return Center(
                          child: Text('Error: ${state.message}'),
                        );
                      }
                       else {
                        return Container();
                      }
                    },
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: brightGray),
                        borderRadius: BorderRadius.circular(8.r),
                        color: white),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'assets/document_icon.svg',
                          width: 24.w,
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        Text(
                          'Lihat laporan Rekapitulasi Pengaduan PDAM',
                          style: caption1.copyWith(color: vampireBlack),
                        ),
                        const Spacer(),
                        SvgPicture.asset('assets/arrow_right_icon.svg')
                      ],
                    ),
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
