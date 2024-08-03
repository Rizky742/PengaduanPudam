import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pengaduan/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pengaduan/features/home/presentation/bloc/periode_bloc.dart';
import 'package:pengaduan/features/pengaduan/presentation/bloc/pengaduan_bloc.dart';
import 'package:pengaduan/features/pengaduan/presentation/widgets/header_widget.dart';
import 'package:pengaduan/features/pengaduan/presentation/widgets/pengaduan_item_widget.dart';
import 'package:pengaduan/theme.dart';

class PengaduanScreen extends StatelessWidget {
  const PengaduanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();
    String role = '';
    String id = '';
    String filter = '';
    var safeAreaPadding = MediaQuery.of(context).padding;
    final periode = context.read<PeriodeBloc>().state;
    final data = context.read<AuthBloc>().state;
    if (data is AuthLoggedIn) {
      role = data.auth.role;
      if (role.toLowerCase() == 'kepala') {
        id = data.auth.divisiId.toString();
      } else {
        id = data.auth.id.toString();
      }
    }
    if (periode is PeriodeSetted) {
      context.read<PengaduanBloc>().add(GetPengaduanEvent(
          month: periode.periode.month.toString(),
          year: periode.periode.year.toString(),
          id: id,
          role: role));
    } else {
      context.read<PengaduanBloc>().add(GetPengaduanEvent(
          month: DateTime.now().month.toString(),
          year: DateTime.now().year.toString(),
          id: id,
          role: role));
    }
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 127.h + safeAreaPadding.top,
            color: blueCola,
          ),
          Padding(
            padding: EdgeInsets.only(
                top: safeAreaPadding.top + 42.h, left: 16.w, right: 16.w),
            child: Column(
              children: [
                const HeaderWidget(
                  title: "List Aduan",
                  jumpToHome: true,
                ),
                SizedBox(height: 32.h), // Add spacing between rows
                Row(
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
                          controller: search,
                          onChanged: (value) {
                            context
                                .read<PengaduanBloc>()
                                .add(GetFilterPengaduanEvent());
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
                          context
                              .read<PengaduanBloc>()
                              .add(GetFilterPengaduanEvent());
                        },
                        color: white,
                        shadowColor: Colors.black,
                        position: PopupMenuPosition.under,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r)),
                        popUpAnimationStyle:
                            AnimationStyle(curve: Curves.linearToEaseOut),
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
                ),
                Expanded(
                  child: BlocBuilder<PengaduanBloc, PengaduanState>(
                    builder: (context, state) {
                      if (state is PengaduanLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is PengaduanLoaded) {
                        final filtered = state.pengaduan.where(
                          (element) {
                            final name = element.nama
                                .toLowerCase()
                                .contains(search.text.toLowerCase());
                            final noPelanggan = element.noPelanggan!
                                .toLowerCase()
                                .contains(search.text.toLowerCase());
                            final status = element.status.toLowerCase() ==
                                filter.toLowerCase();
                            if (search.text.isNotEmpty && filter.isNotEmpty) {
                              return noPelanggan && status || name && status;
                            } else if (search.text.isEmpty &&
                                filter.isNotEmpty) {
                              return status;
                            } else {
                              return noPelanggan || name;
                            }
                          },
                        ).toList();

                        if (filtered.isNotEmpty) {
                          return ListView.builder(
                            itemCount: filtered.length,
                            shrinkWrap: false, // Allow ListView to expand
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            physics:
                                const AlwaysScrollableScrollPhysics(), // Ensure scrolling
                            itemBuilder: (context, index) {
                              final pengaduan = filtered[index];
                              return PengaduanItem(
                                  idAduan: pengaduan.idAduan.toString(),
                                  role: role,
                                  keterangan: pengaduan.keterangan,
                                  jenisAduan: pengaduan.jenisAduan,
                                  noAduan: pengaduan.noAduan,
                                  noPelanggan: pengaduan.noPelanggan,
                                  nama: pengaduan.nama,
                                  alamat: pengaduan.alamat,
                                  status: pengaduan.status,
                                  phoneNumber: pengaduan.noTelepon);
                            },
                          );
                        } else {
                          return const Center(
                            child: Text('Tidak ada data pengaduan'),
                          );
                        }
                      } else if (state is PengaduanError) {
                        return Center(
                          child: Text('Error: ${state.message}'),
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
