import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pengaduan/core/snackbar/snackbar.dart';
import 'package:pengaduan/features/pengaduan/presentation/bloc/send_data_penyelesaian_bloc.dart';
import 'package:pengaduan/features/pengaduan/presentation/bloc/send_penyelesaian_bloc.dart';

import 'package:pengaduan/features/pengaduan/presentation/pages/aduan_selesai_screen.dart';
import 'package:pengaduan/features/pengaduan/presentation/widgets/custom_button_bottom.dart';
import 'package:pengaduan/features/pengaduan/presentation/widgets/desciptions_widget.dart';
import 'package:pengaduan/features/pengaduan/presentation/widgets/header_widget.dart';
import 'package:pengaduan/features/pengaduan/presentation/widgets/invoice_widget.dart';
import 'package:pengaduan/theme.dart';

import '../widgets/opsi_penyelesaian_widget.dart';

class PenyelesaianScreen extends StatelessWidget {
  const PenyelesaianScreen({
    super.key,
    required this.noAduan,
    required this.idAduan,
    this.noPelanggan,
    required this.nama,
    required this.alamat,
    required this.jenisAduan,
    required this.keterangan,
    required this.status,
    required this.idPetugas, required this.namaPetugas,
  });
  final String? noPelanggan;
  final String noAduan;
  final String idAduan;
  final String nama;
  final String alamat;
  final String jenisAduan;
  final String keterangan;
  final String status;
  final String idPetugas;
  final String namaPetugas;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController catatanController = TextEditingController();
    var safeAreaPadding = MediaQuery.of(context).padding;
    context.read<SendPenyelesaianBloc>().add(SendPenyelesaianRemoveImage());
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
                      title: 'Penyelesaian',
                    ),
                    SizedBox(height: 28.h),
                    InvoiceWidget(
                      invoice: noAduan,
                    ),
                    SizedBox(height: 20.h),
                    DescriptionsWidget(
                      jenisAduan: jenisAduan,
                      keterangan: keterangan,
                      status: status,
                      nama: nama,
                      nomor: noPelanggan ?? 'null',
                      alamat: alamat,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Opsi Penyelesaian',
                      style: caption1.copyWith(color: vampireBlack),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 8.h),
                    const OpsiPenyelesaianWidget(),
                    SizedBox(height: 20.h),
                    Text(
                      'Catatan Penyelesaian',
                      style: caption1.copyWith(color: vampireBlack),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 8.h),
                    Container(
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
                      child: TextFormField(
                        onChanged: (value) {
                          context.read<SendPenyelesaianBloc>().add(
                              SendPenyelesaianSetKeterangan(keterangan: value));
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Catatan Penyelesaian kosong';
                          }
                          return null;
                        },
                        style: caption1.copyWith(color: vampireBlack),
                        maxLines: 5,
                        controller: catatanController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(12.w),
                          hintText: 'Ketik Catatan Penyelesaian Tugas....',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Foto Bukti Penyelesaian',
                      style: caption1.copyWith(color: vampireBlack),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 8.h),
                    BlocBuilder<SendPenyelesaianBloc, SendPenyelesaianState>(
                      builder: (context, state) {
                        if (state is SendPenyelesaianSet) {
                          if (state.image != null) {
                            return Column(
                              children: [
                                Image.file(
                                  state.image!,
                                  width: double.infinity,
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                InkWell(
                                  onTap: () {
                                    context
                                        .read<SendPenyelesaianBloc>()
                                        .add(SendPenyelesaianSelectImage());
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.h),
                                    decoration: BoxDecoration(
                                        color: beer,
                                        borderRadius:
                                            BorderRadius.circular(8.r)),
                                    child: Center(
                                        child: Text(
                                      'Edit',
                                      style: heading4.copyWith(
                                          color: Colors.white),
                                    )),
                                  ),
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                InkWell(
                                  onTap: () {
                                    // print('sdfsf');
                                    context
                                        .read<SendPenyelesaianBloc>()
                                        .add(SendPenyelesaianRemoveImage());
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.h),
                                    decoration: BoxDecoration(
                                        color: pastelRed,
                                        borderRadius:
                                            BorderRadius.circular(8.r)),
                                    child: Center(
                                        child: Text(
                                      'Hapus',
                                      style: heading4.copyWith(
                                          color: Colors.white),
                                    )),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return InkWell(
                              onTap: () {
                                context
                                    .read<SendPenyelesaianBloc>()
                                    .add(SendPenyelesaianSelectImage());
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(8.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      blurRadius: 24,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(vertical: 32.h),
                                child: Center(
                                  child: SvgPicture.asset(
                                    'assets/upload_image_icon.svg',
                                    width: 32.w,
                                  ),
                                ),
                              ),
                            );
                          }
                        }
                        return Container();
                      },
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    BlocListener<SendDataPenyelesaianBloc,
                        SendDataPenyelesaianState>(
                      listener: (context, state) {
                        if (state is SendDataPenyelesaianError) {
                          snackbar(context, state.message);
                        } else if (state is SendDataPenyelesaianSuccess) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                     AduanSelesaiScreen(
                                      ditugaskanOleh: state.penyelesaian.ditugaskanOleh,
                                      ditugaskanKepada: state.penyelesaian.ditugaskanKepada,
                                      tanggalPenugasan: state.penyelesaian.targetPenyelesaian,
                                      nomorAduan: state.penyelesaian.noAduan,
                                      alamat: state.penyelesaian.alamat,
                                      nama: state.penyelesaian.nama,
                                      jenisPenyelesaian: state.penyelesaian.jenisPenyelesaian,
                                      tanggalPenyelesaian: state.penyelesaian.tglSelesai,
                                      buktiPenyelesaian: state.penyelesaian.fotoPenyelesaian,
                                      noPelanggan: state.penyelesaian.noPelanggan ?? '',

                                    ),
                              ));
                        }
                      },
                      child: BlocBuilder<SendDataPenyelesaianBloc,
                          SendDataPenyelesaianState>(
                        builder: (context, state) {
                          if (state is SendDataPenyelesaianLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return CustomButtonBottom(
                              title: "Kirim",
                              onPressed: () {
                                if (!formKey.currentState!.validate()) return;
                                final data =
                                    context.read<SendPenyelesaianBloc>().state;
                                if (data is SendPenyelesaianSet) {
                                  if (data.image == null) {
                                    snackbar(context, 'Foto belum terisi');
                                  } else {
                                    context
                                        .read<SendDataPenyelesaianBloc>()
                                        .add(ToggleSendDataPenyelesaianEvent(
                                            image: data.image!,
                                            pengaduanId: idAduan,
                                            petugasId: idPetugas,
                                            keteranganSelesain: data.keterangan,
                                            jenisPenyelesaianId:
                                                data.jenisPenyelesaianId));
                                  }
                                }
                              },
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 32.h,
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
