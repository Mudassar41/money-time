import 'dart:io';

import 'package:atm_tracker/controllers/admin_controller.dart';
import 'package:atm_tracker/models/ad_model.dart';
import 'package:atm_tracker/services/firebase_service1.dart';
import 'package:atm_tracker/services/firebase_services.dart';
import 'package:atm_tracker/services/services.dart';
import 'package:atm_tracker/utils/constant/const.dart';
import 'package:atm_tracker/utils/log/custom_loger.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/utils/widgets/custom_button.dart';
import 'package:atm_tracker/utils/widgets/custom_text.dart';
import 'package:atm_tracker/views/user_side/custom_widgets/user_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class AdUploadingScreen extends StatefulWidget {
  final int bankId;

  AdUploadingScreen({super.key, required this.bankId});

  @override
  State<AdUploadingScreen> createState() => _AdUploadingScreenState();
}

class _AdUploadingScreenState extends State<AdUploadingScreen> {
  final log = CustomLogger(className: 'Admin Controller');

  final _adminController = AdminController.instance;
  late VideoPlayerController _controller;
  final firebaseServiceV1 = FirebaseServiceV1();
  bool isLoading = false;
  int status = 0;
  final firebaseService = FirebaseServices();
  XFile? video;
  final ImagePicker imagePicker = ImagePicker();
  late String views;
  late AdModel adModel;

  @override
  void initState() {
    super.initState();
    getAd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          UserAppBar(
            onBackPressed: () {
              Get.back();
            },
            backIconColor: kBlack,
          ),
          if (isLoading) ...[
            Container(
              height: Get.height * 0.66,
              width: Get.width,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              ),
            )
          ] else if (status == 401) ...[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('No Video Found'),
            )
          ] else if (_controller.value.isInitialized)
            // Text("view $views"),
            ...[
            Text(
              'views ${adModel.views}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: Get.height * 0.66,
              width: Get.width,
              alignment: Alignment.center,
              margin: getMargin(left: 20, right: 20, bottom: 10),
              decoration: BoxDecoration(borderRadius: raduis_16),
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            ),
          ],
          Center(
            child: InkWell(
              onTap: () {
                pickVideo();
              },
              child: LargeText(text: "Select Video", color: kPrimary),
            ),
          ),

          if (video != null)
            CustomButton(
              title: "Upload",
              width: Get.width,
              margin: getMargin(top: 10, left: 20, right: 20),
              onTap: () {
                firebaseServiceV1.addUpdateAd(
                  widget.bankId,
                  video!.path,
                );
                // if (_adminController.video != null)
                //  uploadVideo(widget.bankId, video!);
                // else
                //   Services.errorMessage("Please select a video");
                // log.i(
                //     "Video Controller Value: ${_adminController.remoteVideoController?.value}");
              },
            ),
          // ElevatedButton(
          //   onPressed: () {
          //     playNetworkVideo('https://example.com/video.mp4');
          //   },
          //   child: Text('Play Network Video'),
          // ),
          // ElevatedButton(
          //   onPressed: () {
          //     pickVideo();
          //   },
          //   child: Text('Pick Video from Gallery'),
          // ),
        ],
      ),

      //  Column(
      //   children: [
      //     UserAppBar(
      //       onBackPressed: () {
      //         Get.back();
      //       },
      //       backIconColor: kBlack,
      //     ),
      //     Align(
      //       alignment: Alignment.centerLeft,
      //       child: Obx(
      //         () => SmallText(
      //           text: "Views: ${_adminController.views.value}",
      //           margin: getMargin(left: 20, bottom: 10),
      //         ),
      //       ),
      //     ),
      //     if (isLoading)
      //       Container(
      //         height: Get.height * 0.66,
      //         width: Get.width,
      //         child: Center(
      //           child: CircularProgressIndicator(
      //             color: Colors.green,
      //           ),
      //         ),
      //       )
      //     else if (status == 401)
      //       Text('No Video Found')
      //     else
      //       _controller.value.isInitialized
      //           ? Container(
      //               height: Get.height * 0.66,
      //               width: Get.width,
      //               alignment: Alignment.center,
      //               margin: getMargin(left: 20, right: 20, bottom: 10),
      //               decoration: BoxDecoration(borderRadius: raduis_16),
      //               child: AspectRatio(
      //                 aspectRatio: _controller.value.aspectRatio,
      //                 child: VideoPlayer(_controller),
      //               ),
      //             )
      //           : Container(
      //               height: Get.height * 0.66,
      //               width: Get.width,
      //               child: CircularProgressIndicator(
      //                 color: Colors.green,
      //               ),
      //             ),
      //     Center(
      //       child: InkWell(
      //         onTap: () {
      //           pickVideo();
      //         },
      //         child: LargeText(text: "Select Video", color: kPrimary),
      //       ),
      //     ),
      //     CustomButton(
      //       title: "Upload",
      //       width: Get.width,
      //       margin: getMargin(top: 10, left: 20, right: 20),
      //       onTap: () {
      //         if (_adminController.video != null)
      //           _adminController.uploadVideo(widget.bankId);
      //         else
      //           Services.errorMessage("Please select a video");
      //         log.i(
      //             "Video Controller Value: ${_adminController.remoteVideoController?.value}");
      //       },
      //     ),
      //   ],
      // ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (!isLoading) _controller.dispose();
  }

  getAd() async {
    setState(() {
      isLoading = true;
    });
    adModel = await firebaseService.getAd(widget.bankId) ??
        AdModel(adUrl: '', bankId: 401, views: 0);
    if (adModel.bankId != 401) {
      views = adModel.views.toString();
      _controller = VideoPlayerController.network(
        adModel.adUrl,
      )..initialize().then((_) async {
          isLoading = false;
          await _controller.play();
          setState(() {});
        });
    } else {
      status = 401;
      isLoading = false;
      setState(() {});
    }
  }

  pickVideo() async {
    video = await imagePicker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      _controller = VideoPlayerController.file(File(video!.path))
        ..initialize().then((value) async {
          print(
              'value .>>>>>>>>>>>>>>>>>>>>>.${_controller.value.isInitialized}');
          status = 0;
          setState(() {});

          await _controller.play();
        });
    }
  }

  uploadVideo(int bankId, XFile video) async {
    Services.showLoading();
    await FirebaseServices().uploadAdVideo(video.path, bankId);
    // views.value = 0;
    Services.hideLoading();
    Services.successMessage("Ad Video Uploaded");
  }
}
