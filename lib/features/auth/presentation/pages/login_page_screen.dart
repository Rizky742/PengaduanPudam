import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pengaduan/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pengaduan/features/auth/presentation/bloc/ui_bloc.dart';
import 'package:pengaduan/features/auth/presentation/widgets/set_up_url.dart';
import 'package:pengaduan/features/home/presentation/pages/home_page_screen.dart';
import 'package:pengaduan/features/pengaduan/presentation/widgets/custom_button_bottom.dart';
import 'package:pengaduan/theme.dart';
import '../widgets/auth_field.dart';
import '../widgets/check_box_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static final formKey = GlobalKey<FormState>();
  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController passwordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    var safeAreaPadding = MediaQuery.of(context).padding;
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
                  height: safeAreaPadding.top + 12.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.w, color: brightGray),
                        borderRadius: BorderRadius.circular(40.r),
                        // border:
                      ),
                      child: const SetUpURL(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40.h,
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
                  input: TextInputAction.next,
                ),
                SizedBox(
                  height: 16.h,
                ),
                AuthField(
                  controller: passwordController,
                  title: 'Kata Sandi',
                  hintText: 'Masukkan Kata Sandi',
                  type: Type.password,
                  input: TextInputAction.none,
                ),
                BlocBuilder<UiBloc, UiState>(builder: (context, state) {
                  if (state is UiInitial) {
                    return CheckBoxButton(
                      isCheckbox: state.rememberMe,
                      onChanged: (bool? value) {
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
