import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pengaduan/core/snackbar/snackbar.dart';
import 'package:pengaduan/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pengaduan/features/pengaduan/presentation/bloc/get_penugasan_bloc.dart';
import 'package:pengaduan/features/pengaduan/presentation/bloc/send_data_penyelesaian_bloc.dart';
import 'package:pengaduan/features/pengaduan/presentation/pages/aduan_selesai_screen.dart';
import 'package:pengaduan/features/pengaduan/presentation/pages/bukti_penugasan.dart';
import 'package:pengaduan/features/pengaduan/presentation/pages/penugasan_screen.dart';
import 'package:pengaduan/features/pengaduan/presentation/pages/penyelesaian_screen.dart';
import 'package:pengaduan/theme.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class PengaduanItem extends StatelessWidget {
  const PengaduanItem({
    super.key,
    required this.noAduan,
    required this.idAduan,
    required this.noPelanggan,
    required this.nama,
    required this.alamat,
    required this.status,
    required this.phoneNumber,
    required this.jenisAduan,
    required this.keterangan,
    required this.role,
    required this.idPetugas,
    required this.namaPetugas,
  });

  final String? noPelanggan;
  final String noAduan;
  final String idAduan;
  final String nama;
  final String alamat;
  final String phoneNumber;
  final String jenisAduan;
  final String keterangan;
  final String status;
  final String role;
  final String idPetugas;
  final String namaPetugas;

  Future<void> _makePhoneCall(
      String menu, BuildContext context, String phoneNumber) async {
    // print(phoneNumber);
    // print(phoneNumber.isEmpty);
    if (phoneNumber.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Pemberitahuan'),
            content: const Text('Nomor telepon tidak tersedia.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }
    Uri url;
    if (menu == 'whatsapp') {
      url = Uri.parse("https://wa.me/$phoneNumber?text=");
    }
    url = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    // print('sdfsd');
    Color mainColor;
    Color backgroundColor;
    String text;
    switch (status) {
      case 'Belum Ditugaskan':
        mainColor = pastelRed;
        text = 'Belum Ditugaskan';
        backgroundColor = lavenderBlush;
        break;
      case 'Ditugaskan':
        mainColor = blueCola;
        backgroundColor = lavenderWeb;
        text = 'Ditugaskan';
      case 'Belum Diselesaikan':
        mainColor = beer;
        backgroundColor = cosmicLatte;
        text = 'Belum Diselesaikan';
      default:
        mainColor = caribbeanGreen;
        backgroundColor = bubbles;
        text = 'Selesai';
    }
    return GestureDetector(
      onTap: () {
        // if (status.toLowerCase() == 'ditugaskan') {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => PenyelesaianScreen(
        //         namaPetugas: namaPetugas,
        //         idPetugas: idPetugas,
        //         idAduan: idAduan,
        //         status: status,
        //         jenisAduan: jenisAduan,
        //         keterangan: keterangan,
        //         alamat: alamat,
        //         nama: nama,
        //         noAduan: noAduan,
        //         noPelanggan: noPelanggan,
        //       ),
        //     ),
        //   );
        // }
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: IntrinsicHeight(
          child: Container(
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
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/sudah_ditugasi_icon.svg',
                  width: 24.w,
                ),
                SizedBox(
                  width: 8.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                border: Border.all(
                                  width: 0.5.w,
                                  color: mainColor,
                                ),
                                borderRadius:
                                    BorderRadiusDirectional.circular(100),
                              ),
                              child: Center(
                                child: Text(
                                  text,
                                  style: caption2.copyWith(color: mainColor),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: noPelanggan!.isNotEmpty
                                    ? const Color(0xffE8F5E9)
                                    : const Color(0xffFCE4EC),
                                border: Border.all(
                                  width: 0.5.w,
                                  color: noPelanggan!.isNotEmpty
                                      ? const Color(0xff2E7D32)
                                      : const Color(0xffC2185B),
                                ),
                                borderRadius:
                                    BorderRadiusDirectional.circular(100),
                              ),
                              child: Center(
                                child: Text(
                                  noPelanggan!.isNotEmpty
                                      ? 'Pelanggan'
                                      : "Non Pelanggan",
                                  style: noPelanggan!.isNotEmpty
                                      ? caption2.copyWith(
                                          color: const Color(0xff2E7D32))
                                      : caption2.copyWith(
                                          color: const Color(0xffC2185B)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              noAduan.toString(),
                              style: heading3.copyWith(
                                color: blueCola,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      noPelanggan!.isNotEmpty
                          ? Text(
                              '$noPelanggan - $nama',
                              style: caption1.copyWith(color: graniteGray),
                            )
                          : Text(
                              nama,
                              style: caption1.copyWith(color: graniteGray),
                            ),
                      Text(
                        jenisAduan,
                        style: caption2.copyWith(color: graniteGray),
                      ),
                      Text(
                        alamat.toString(),
                        style: caption2.copyWith(color: graniteGray),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        PopupMenuButton<String>(
                          icon: SvgPicture.asset(
                            'assets/phone_icon.svg',
                            width: 17.w,
                          ),
                          color: Colors.white,
                          shadowColor: Colors.black,
                          elevation: 5,
                          position: PopupMenuPosition.under,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r)),
                          popUpAnimationStyle:
                              AnimationStyle(curve: Curves.linearToEaseOut),
                          onSelected: (value) async {
                            // print(phoneNumber);
                            await _makePhoneCall(value, context, phoneNumber);
                          },
                          itemBuilder: (context) {
                            List<PopupMenuEntry<String>> menu = [];
                            menu.add(
                              const PopupMenuItem<String>(
                                value: 'whatsapp',
                                child: Text('Whatsapp'),
                              ),
                            );
                            menu.add(
                              const PopupMenuItem<String>(
                                value: 'phone',
                                child: Text('Phone'),
                              ),
                            );
                            return menu;
                          },
                        ),
                        // InkWell(
                        //   onTap: () => _makePhoneCall(context, phoneNumber),
                        //   child: SvgPicture.asset(
                        //     'assets/phone_icon.svg',
                        //     width: 17.w,
                        //   ),
                        // ),
                        SizedBox(
                          width: 12.h,
                        ),
                        MultiBlocListener(
                          listeners: [
                            BlocListener<GetPenugasanBloc, GetPenugasanState>(
                              listener: (context, state) {
                                if (state is GetPenugasanloaded) {
                                  final stateAuth =
                                      context.read<AuthBloc>().state;
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
                                  // print(state.penugasan.idAduan);
                                } else if (state is GetPenugasanError) {
                                  print(state.message);
                                }
                              },
                            ),
                            BlocListener<SendDataPenyelesaianBloc,
                                SendDataPenyelesaianState>(
                              listener: (context, state) {
                                if (state is SendDataPenyelesaianLoading) {
                                  //  showDialog(
                                  //   context: context,
                                  //   builder: (context) {
                                  //     return Container(
                                  //       child: Text("Loading"),
                                  //     );
                                  //   },
                                  // );
                                  print('Loaddingg');
                                }
                                else if (state is SendDataPenyelesaianSuccess) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AduanSelesaiScreen(
                                            nomorAduan:
                                                state.penyelesaian.noAduan,
                                            noPelanggan: state
                                                    .penyelesaian.noPelanggan ??
                                                '',
                                            nama: state.penyelesaian.nama,
                                            alamat: state.penyelesaian.alamat,
                                            ditugaskanKepada: state
                                                .penyelesaian.ditugaskanKepada,
                                            ditugaskanOleh: state
                                                .penyelesaian.ditugaskanOleh,
                                            tanggalPenugasan: state.penyelesaian
                                                .targetPenyelesaian,
                                            tanggalPenyelesaian:
                                                state.penyelesaian.tglSelesai,
                                            jenisPenyelesaian: state
                                                .penyelesaian.jenisPenyelesaian,
                                            buktiPenyelesaian: state
                                                .penyelesaian.fotoPenyelesaian),
                                      ));
                                } else if (state is SendDataPenyelesaianError) {
                                  // print('sdfdsfs');
                                  snackbar(context, state.message);
                                }
                              },
                            ),
                          ],
                          child: PopupMenuButton<String>(
                            icon: SvgPicture.asset(
                              'assets/option_icon.svg',
                              width: 17.w,
                            ),
                            color: Colors.white,
                            shadowColor: Colors.black,
                            elevation: 5,
                            position: PopupMenuPosition.under,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r)),
                            popUpAnimationStyle:
                                AnimationStyle(curve: Curves.linearToEaseOut),
                            onSelected: (value) {
                              if (value == 'penugasan') {
                                if (status.toLowerCase() ==
                                    'belum ditugaskan') {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PenugasanScreen(
                                          idAduan: idAduan,
                                          status: status,
                                          alamat: alamat,
                                          jenisAduan: jenisAduan,
                                          keterangan: keterangan,
                                          nama: nama,
                                          noAduan: noAduan,
                                          noPelanggan: noPelanggan,
                                        ),
                                      ));
                                }
                              } else if (value == 'cetak_spk') {
                                print(idAduan);
                                context.read<GetPenugasanBloc>().add(
                                    toggleGetPenugasanEvent(
                                        int.parse(idAduan)));
                              } else if (value == 'penyelesaian') {
                                if (status.toLowerCase() == 'ditugaskan') {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PenyelesaianScreen(
                                                noAduan: noAduan,
                                                idAduan: idAduan,
                                                nama: nama,
                                                alamat: alamat,
                                                jenisAduan: jenisAduan,
                                                keterangan: keterangan,
                                                status: status,
                                                idPetugas: idPetugas,
                                                namaPetugas: namaPetugas),
                                      ));
                                }
                              } else if (value == 'cetak_bpk') {
                                context.read<SendDataPenyelesaianBloc>().add(
                                    ToggleGetDataPenyelesaianById(id: idAduan));
                              }
                            },
                            itemBuilder: (context) {
                              List<PopupMenuEntry<String>> menu = [];
                              if (role.toLowerCase() == 'kepala' &&
                                  status.toLowerCase() == 'belum ditugaskan') {
                                menu.add(
                                  const PopupMenuItem<String>(
                                    value: 'penugasan',
                                    child: Text('Penugasan'),
                                  ),
                                );
                              }
                              if (status.toLowerCase() != 'belum ditugaskan') {
                                if (status.toLowerCase() == 'ditugaskan') {
                                  menu.add(
                                    const PopupMenuItem<String>(
                                      value: 'penyelesaian',
                                      child: Text('Penyelesaian'),
                                    ),
                                  );
                                }

                                if (role.toLowerCase() == 'kepala') {
                                  menu.add(
                                    const PopupMenuItem<String>(
                                      value: 'cetak_spk',
                                      child: Text('Cetak SPK'),
                                    ),
                                  );
                                }
                                if (status.toLowerCase() == 'diselesaikan') {
                                  menu.add(
                                    const PopupMenuItem<String>(
                                      value: 'cetak_bpk',
                                      child: Text('Cetak BPK'),
                                    ),
                                  );
                                }
                              }
                              return menu;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
