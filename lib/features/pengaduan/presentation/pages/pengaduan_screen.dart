import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pengaduan/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pengaduan/features/home/presentation/bloc/periode_bloc.dart';
import 'package:pengaduan/features/pengaduan/presentation/bloc/pengaduan_bloc.dart';
import 'package:pengaduan/features/pengaduan/presentation/widgets/header_widget.dart';
import 'package:pengaduan/features/pengaduan/presentation/widgets/pengaduan_item_widget.dart';
import 'package:pengaduan/features/pengaduan/presentation/widgets/search_fliter_widget.dart';
import 'package:pengaduan/theme.dart';

class PengaduanScreen extends StatelessWidget {
  const PengaduanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();
    String role = '';
    String id = '';
    // String filter = '';
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
                SearchFliterWidget(controller: search),
                Expanded(
                  child: BlocBuilder<PengaduanBloc, PengaduanState>(
                    builder: (context, state) {
                      if (state is PengaduanLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is PengaduanLoaded) {
                        final filter = state.filter ?? '';
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
