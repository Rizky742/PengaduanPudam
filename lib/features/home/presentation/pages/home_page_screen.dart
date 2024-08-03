import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pengaduan/features/home/presentation/bloc/navigation_bloc.dart';
import 'package:pengaduan/features/home/presentation/pages/home_screen.dart';
import 'package:pengaduan/features/home/presentation/pages/profil_screen.dart';
import 'package:pengaduan/features/pengaduan/presentation/pages/pengaduan_navigator.dart';
import 'package:pengaduan/theme.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    // final navigationBloc = context.read<NavigationBloc>();
    // final pageController = navigationBloc.pageController;
    return BlocProvider(
      create: (context) => NavigationBloc(PageController()),
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          final selectedIndex =
              (state is NavigationUpdated) ? state.selectedIndex : 0;
          final pageController = context.read<NavigationBloc>().pageController;
          return Scaffold(
            backgroundColor: const Color(0xffF8F8F9),
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              onPageChanged: (index) {
                context.read<NavigationBloc>().add(ChangePage(index));
              },
              children: const [
                HomeScreen(),
                PengaduanNavigator(),
                ProfilScreen()
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    label: 'Beranda',
                    icon: SvgPicture.asset(
                      selectedIndex == 0
                          ? 'assets/home_blue_icon.svg'
                          : 'assets/home_icon.svg',
                      width: 24.w,
                    ),
                    backgroundColor: blueCola),
                BottomNavigationBarItem(
                  label: 'List Aduan',
                  icon: SvgPicture.asset(
                    selectedIndex == 1
                        ? 'assets/pengaduan_blue_icon.svg'
                        : 'assets/pengaduan_icon.svg',
                    width: 24.w,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Profil',
                  icon: SvgPicture.asset(
                    selectedIndex == 2
                        ? 'assets/profil_blue_icon.svg'
                        : 'assets/profil_icon.svg',
                    width: 24.w,
                  ),
                ),
              ],
              currentIndex: selectedIndex,
              selectedItemColor: blueCola,
              onTap: (index) {
                // ref.read(selectedIndexProvider.notifier).state = index;
                // pageController.jumpToPage(index);
                context.read<NavigationBloc>().add(ChangePage(index));
              },
            ),
          );
        },
      ),
    );
  }
}
