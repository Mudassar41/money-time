import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../services/services.dart';
import '../utils/theme/colors.dart';

class ImageController {
  static final ImagePicker _picker = ImagePicker();

  static Future<File?> pickMediaWithCropper({
    bool isFromGallery = true,
    bool isCircle = false,
    double ratioX = 16,
    double ratioY = 10,
  }) async {
    Services.showLoading();
    final file = await _picker.pickImage(
        source: isFromGallery ? ImageSource.gallery : ImageSource.camera);
    if (file == null) {
      Services.hideLoading();
      return null;
    }

    final CroppedFile? _croppedFile = await ImageCropper().cropImage(
        sourcePath: file.path,
        cropStyle: isCircle ? CropStyle.circle : CropStyle.rectangle,
        aspectRatio: CropAspectRatio(ratioX: ratioX, ratioY: ratioY),
        uiSettings: [
          AndroidUiSettings(
              hideBottomControls: true, activeControlsWidgetColor: kPrimary),
          // IOSUiSettings(
          //   activeControlsWidgetColor: AuthController.instance.isDoctor.isFalse?primaryBlue:primaryTeal

          // )
        ]);
    if (_croppedFile != null) {
      Services.hideLoading();
      return File(_croppedFile.path);
    } else {
      Services.hideLoading();
      return null;
    }
  }

  static Future<File?> pickOnlyMedia({bool isFromGallery = true}) async {
    Services.showLoading();
    final file = await _picker.pickImage(
        source: isFromGallery ? ImageSource.gallery : ImageSource.camera);
    Services.hideLoading();
    if (file == null) return null;
    return File(file.path);
  }

  static Future<List<File>> pickMultiFiles() async {
    Services.showLoading();

    final pickedFiles = await ImagePicker().pickMultiImage(
      imageQuality: 50,
    );
    Services.hideLoading();

    return pickedFiles.map((e) => File(e.path)).toList();
  }
}
