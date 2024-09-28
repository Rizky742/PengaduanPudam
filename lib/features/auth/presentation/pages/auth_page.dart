import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pengaduan/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pengaduan/features/auth/presentation/pages/login_page_screen.dart';
import 'package:pengaduan/features/home/presentation/pages/home_page_screen.dart';
import 'package:pengaduan/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    super.initState();
    _checkProfile(); // Cek profil pada saat inisialisasi
  }

  Future<void> _checkProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var profile = prefs.getString("profile");
    var user = prefs.getString("user");
    if (profile != null && user != null) {
      var email = jsonDecode(user)['username'];
      var password = jsonDecode(user)['password'];

      // Trigger the login event in AuthBloc
      context.read<AuthBloc>().add(LoginEvent(email, password));
    } else {
      // Tambahkan delay 1 detik sebelum pindah ke LoginPage
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthLoggedIn) {
          // Tambahkan delay 1 detik sebelum pindah ke halaman HomePage
          await Future.delayed(const Duration(seconds: 1));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Homepage()),
          );
        }
        // Jika ada error, arahkan kembali ke LoginPage
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/pdam_main_logo.png',
                width: 130.w,
              ),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: Text(
                  'Perumdam Bayuangga',
                  style: heading1,
                ),
              ),
              Center(
                child: Text(
                  'Solusi Permasalahan Air Masyarakat',
                  style: body2.copyWith(color: spanishGray),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
