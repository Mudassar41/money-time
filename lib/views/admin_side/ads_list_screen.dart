// import 'package:atm_tracker/controllers/admin_controller.dart';
import 'package:atm_tracker/controllers/admin_controller.dart';
import 'package:atm_tracker/utils/constant/strings.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/views/admin_side/ad_uploading_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdsListScreen extends StatelessWidget {
  final _adminController = Get.put(AdminController());
  AdsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ads related to Banks'),
      ),
      backgroundColor: kPrimary,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: banksList.length,
          itemBuilder: (context, index) {
            return Card(
              child: InkWell(
                onTap: () {
                  Get.to(
                    // _adminController.getRemoteAdVideo(index)
                   AdUploadingScreen(bankId: index),
                  );

                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          banksList[index],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
