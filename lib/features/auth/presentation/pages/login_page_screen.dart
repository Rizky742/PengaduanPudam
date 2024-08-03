import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pengaduan/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pengaduan/features/auth/presentation/bloc/ui_bloc.dart';
import 'package:pengaduan/features/home/presentation/pages/home_page_screen.dart';
import 'package:pengaduan/features/pengaduan/presentation/widgets/custom_button_bottom.dart';
import 'package:pengaduan/theme.dart';
import '../widgets/auth_field.dart';
import '../widgets/check_box_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    // final isCheckbox = ref.watch(checkboxProvider);
    // final emailController = ref.watch(emailProvider);
    // final passwordController = ref.watch(passwordProvider);
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: ScreenUtil().screenHeight,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 121.h,
                ),
                Center(
                  child: Image.asset(
                    'assets/pdam_main_logo.png',
                    width: 130.w,
                  ),
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
                SizedBox(
                  height: 40.h,
                ),
                AuthField(
                  controller: emailController,
                  hintText: "Masukkan Username",
                  title: 'Username',
                  type: Type.email,
                ),
                SizedBox(
                  height: 16.h,
                ),
                AuthField(
                  controller: passwordController,
                  title: 'Kata Sandi',
                  hintText: 'Masukkan Kata Sandi',
                  type: Type.password,
                ),
                BlocBuilder<UiBloc, UiState>(builder: (context, state) {
                  if (state is UiInitial) {
                    return CheckBoxButton(
                      isCheckbox: state.rememberMe,
                      onChanged: (bool? value) {
                        // ref.read(checkboxProvider.notifier).state = !isCheckbox;
                        context.read<UiBloc>().add(ToggleRememberMeEvent());
                      },
                    );
                  }
                  return Container();
                }),
                const Spacer(),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: pastelRed,
                          content: Text(state.message),
                        ),
                      );
                    } else if (state is AuthLoggedIn) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Homepage(),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return CustomButtonBottom(
                        title: 'Masuk',
                        onPressed: () {
                          if (!formKey.currentState!.validate()) return;
                          context.read<AuthBloc>().add(LoginEvent(
                              emailController.text, passwordController.text));
                        });
                  },
                ),
                SizedBox(
                  height: 48.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
