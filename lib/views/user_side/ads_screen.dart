import 'package:atm_tracker/controllers/user_controller.dart';
import 'package:atm_tracker/utils/constant/const.dart';
import 'package:atm_tracker/utils/theme/colors.dart';
import 'package:atm_tracker/utils/utils.dart';
import 'package:atm_tracker/utils/widgets/custom_text.dart';
import 'package:atm_tracker/views/user_side/atm_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class AdScreen extends StatefulWidget {
  final int index;

  AdScreen({required this.index});

  @override
  State<AdScreen> createState() => _AdScreenState();
}

class _AdScreenState extends State<AdScreen> {
  final _userController = Get.find<UserController>();

  @override
  initState() {
    _userController.videoPlayerController!.addListener(_listner);
    super.initState();
  }

  void _listner() {
    final result =
        _userController.videoPlayerController!.value.position.inSeconds ==
            _userController.videoPlayerController!.value.duration.inSeconds;
    if (result) {
      _userController.videoPlayerController!.pause();
      Get.off(() => AtmDetailsScreen(
          locationModel: _userController.filteredList[widget.index]));
    }
  }

  @override
  void dispose() {
    _userController.videoPlayerController?.removeListener(_listner);
    _userController.videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Padding(
          padding: getPadding(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmallText(
                text: "AD",
                color: kBlack,
                size: getFontSize(20),
                margin: getMargin(bottom: 6, left: 6),
              ),
              Obx(() {
                _userController.videoReady.value;
                return ClipRRect(
                  borderRadius: raduis_16,
                  child: _userController.videoPlayerController != null &&
                          _userController
                              .videoPlayerController!.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _userController
                              .videoPlayerController!.value.aspectRatio,
                          child: VideoPlayer(
                            _userController.videoPlayerController!,
                          ),
                        )
                      : SizedBox(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
