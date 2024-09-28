import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pengaduan/features/home/presentation/bloc/navigation_bloc.dart';
import 'package:pengaduan/theme.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
    required this.title,
    this.jumpToHome,
    this.jumpToPage,
    this.rightIcon = false,
  });

  final String title;
  final bool? jumpToHome;
  final Widget? jumpToPage;
  final bool rightIcon;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Text(
            title,
            style: heading2.copyWith(color: white),
          ),
        ),
        Positioned(
          left: 0,
          child: GestureDetector(
            onTap: () {
              if (jumpToHome == true) {
                final pageController =
                    context.read<NavigationBloc>().pageController;
                pageController.jumpToPage(0);
              } else if (jumpToPage != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => jumpToPage!,
                  ),
                );
              } else {
                Navigator.pop(context);
              }
            },
            child: SvgPicture.asset(
              'assets/arrow_left_icon.svg',
              width: 24.w,
            ),
          ),
        ),
        if (rightIcon)
          Positioned(
            right: 0,
            child: SvgPicture.asset(
              'assets/printer_connected_icon.svg',
              width: 32.w,
            ),
          ),
      ],
    );
  }
}
