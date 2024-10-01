import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pengaduan/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<dynamic> setUpDialog(
    BuildContext context, TextEditingController urlController) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String initialValue = prefs.getString('api_url') ?? '';

  // Set the initial value to the controller
  urlController.text = initialValue;

  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Material(
            borderRadius: BorderRadius.circular(16.r),
            color: Colors.transparent, // Set the background color of the dialog container
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(16.r),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 10.h,
                horizontal: 16.w,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Setup URL',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  TextFormField(
                    controller: urlController, // Removed initialValue
                    decoration: InputDecoration(
                      hintText: 'Masukkan URL',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    keyboardType: TextInputType.url,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close dialog
                        },
                        child: const Text('Cancel'),
                      ),
                      SizedBox(width: 8.w),
                      ElevatedButton(
                        onPressed: () async {
                          // Save the URL using SharedPreferences
                          String url = urlController.text.trim();
                          if (url.isNotEmpty) {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setString('api_url', url);
                            Navigator.pop(context); // Close dialog after saving
                          }
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

