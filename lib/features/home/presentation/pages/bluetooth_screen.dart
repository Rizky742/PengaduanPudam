import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pengaduan/application/providers/bluetooth_provider.dart';
import 'package:pengaduan/features/home/presentation/widgets/bluetooth_item_widget.dart';
import 'package:pengaduan/features/pengaduan/presentation/widgets/header_widget.dart';
import 'package:pengaduan/theme.dart';

class BluetoothScreen extends ConsumerWidget {
  const BluetoothScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var safeAreaPadding = MediaQuery.of(context).padding;
    final isBluetooth = ref.watch(bluetoothAcces);

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderWidget(
                    title: 'Pengaturan Bluetooth',
                  ),
                  SizedBox(height: 28.h),
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: brightGray),
                        borderRadius: BorderRadius.circular(8.r),
                        color: white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bluetooth',
                              style: body1.copyWith(color: vampireBlack),
                            ),
                            Text(
                              'PDAM Bluetooth',
                              style: caption1.copyWith(color: graniteGray),
                            ),
                          ],
                        ),
                        Switch(
                          value: isBluetooth,
                          activeColor: blueCola,
                          onChanged: (value) {
                            ref.read(bluetoothAcces.notifier).state = value;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  const BluetoothItemWidget(
                    title: "EPSON-HDC135",
                    status: Status.connected,
                  ),
                  const BluetoothItemWidget(
                    title: "EPSON-HDC135",
                    status: Status.disconnected,
                  ),
                  const BluetoothItemWidget(
                    title: "EPSON-HDC135",
                    status: Status.disconnected,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
