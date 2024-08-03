import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pengaduan/features/auth/presentation/bloc/ui_bloc.dart';
import 'package:pengaduan/theme.dart';

enum Type { email, password }

// ignore: must_be_immutable
class AuthField extends StatelessWidget {
  AuthField({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
    required this.type,
  });
  final TextEditingController controller;
  final String title;
  final String hintText;
  Type type;

  @override
  Widget build(BuildContext context) {
    // final isVisible = ref.watch(obscureText);
    String menuType = '';
    switch (type) {
      case Type.email:
        menuType = 'email';
        break;
      case Type.password:
        menuType = 'password';
        break;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: caption1,
        ),
        SizedBox(
          height: 4.h,
        ),
        BlocBuilder<UiBloc, UiState>(
          builder: (context, state) {
            bool obscureText = true;
            if (state is UiInitial) {
              obscureText = state.obscureText;
            }
            return TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "$title belum terisi";
                }
                return null;
              },
              obscureText: menuType == 'password' ? obscureText : false,
              // obscureText: state.obscureText,
              controller: controller,
              decoration: InputDecoration(
                suffixIcon: menuType == 'password'
                    ? IconButton(
                        onPressed: () {
                          // ref.read(obscureText.notifier).state = !isVisible;
                          context
                              .read<UiBloc>()
                              .add(ToggleObscureTextEvent());
                        },
                        icon: SvgPicture.asset(
                          obscureText
                              ? 'assets/eyes_open_icon.svg'
                              : 'assets/eyes_close_icon.svg',
                          // icon: SvgPicture.asset(
                          //   'assets/eyes_open_icon.svg',
                          //   width: 25.w,
                        ),
                      )
                    : null,
                hintText: hintText,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r)),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              ),
            );
          },
        )
      ],
    );
  }
}
