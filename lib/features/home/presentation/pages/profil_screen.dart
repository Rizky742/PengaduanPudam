import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pengaduan/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pengaduan/features/home/presentation/widgets/profile_menu_item_widget.dart';
import 'package:pengaduan/features/pengaduan/presentation/widgets/header_widget.dart';
import 'package:pengaduan/theme.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var safeAreaPadding = MediaQuery.of(context).padding;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 187.h + safeAreaPadding.top,
            color: blueCola,
          ),
          Padding(
            padding: EdgeInsets.only(
                top: safeAreaPadding.top + 42.h, left: 16.w, right: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const HeaderWidget(
                  title: 'Profile',
                  jumpToHome: true,
                ),
                SizedBox(
                  height: 40.h,
                ),
                CircleAvatar(
                  radius: 70.w,
                  backgroundImage: const AssetImage('assets/profil.png'),
                ),
                SizedBox(
                  height: 20.h,
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoggedIn) {
                      return Column(
                        children: [
                          Text(
                            state.auth.nama,
                            style: heading3.copyWith(color: vampireBlack),
                          ),
                          Text(
                            '${state.auth.namaDivisi} | ${state.auth.role}',
                            style: caption1.copyWith(
                              color: spanishGray,
                            ),
                          ),
                        ],
                      );
                    }
                    return Container();
                  },
                ),
                SizedBox(
                  height: 40.h,
                ),
                ProfileMenuItemWidget(
                  icon: 'assets/password_icon.svg',
                  title: 'Ganti Kata Sandi',
                  function: () {},
                ),
                SizedBox(
                  height: 12.h,
                ),
                ProfileMenuItemWidget(
                  icon: 'assets/logout_icon.svg',
                  title: 'Keluar',
                  function: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
