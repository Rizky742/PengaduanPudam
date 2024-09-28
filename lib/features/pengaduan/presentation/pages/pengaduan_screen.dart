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

  static TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final search = context.read<TextControllerCubit>().searchController;
    String role = '';
    String id = '';
    String idPetugas = '';
    String nama = '';
    var safeAreaPadding = MediaQuery.of(context).padding;
    final periode = context.read<PeriodeBloc>().state;
    final data = context.read<AuthBloc>().state;
    // final pengaduan = context.read<PengaduanBloc>().state;
    if (data is AuthLoggedIn) {
      role = data.auth.role;
      idPetugas = data.auth.id.toString();
      nama = data.auth.nama;
      if (role.toLowerCase() == 'kepala') {
        id = data.auth.divisiId.toString();
      } else {
        id = data.auth.id.toString();
      }
    }
    // if (pengaduan is PengaduanLoaded) {
    // }
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
    Future<void> refresh() async {
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
                SearchFliterWidget(
                  controller: search,
                  role: role,
                ),
                SizedBox(height: 20.h),
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
                            final noAduan = element.noAduan
                                .toLowerCase()
                                .contains(search.text.toLowerCase());
                            if (search.text.isNotEmpty && filter.isNotEmpty) {
                              return noPelanggan && status ||
                                  name && status ||
                                  noAduan && status;
                            } else if (search.text.isEmpty &&
                                filter.isNotEmpty) {
                              return status;
                            } else {
                              return noPelanggan || name || noAduan;
                            }
                          },
                        ).toList();

                        if (filtered.isNotEmpty) {
                          return RefreshIndicator(
                            onRefresh: refresh,
                            child: ListView.builder(
                              itemCount: filtered.length,
                              shrinkWrap: false, // Allow ListView to expand
                              padding: EdgeInsets.zero,
                              physics:
                                  const AlwaysScrollableScrollPhysics(), // Ensure scrolling
                              itemBuilder: (context, index) {
                                final pengaduan = filtered[index];
                                return PengaduanItem(
                                    idPetugas: idPetugas,
                                    namaPetugas: nama,
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
                            ),
                          );
                        } else {
                          return const Center(
                            child: Text('Tidak ada data pengaduan'),
                          );
                        }
                      } else if (state is PengaduanError) {
                        return RefreshIndicator(
                          onRefresh:
                              refresh, // Menjalankan fungsi refresh ketika pull-to-refresh
                          child: ListView(
                            physics:
                                const AlwaysScrollableScrollPhysics(), // Memastikan ListView bisa di-scroll meskipun tidak ada data
                            children: [
                              Center(
                                child: Text(
                                    'Error: ${state.message}'), // Menampilkan pesan error
                              ),
                            ],
                          ),
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
