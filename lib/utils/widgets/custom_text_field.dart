import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../utils/constant/const.dart';
import '../../utils/theme/theme.dart';
import '../theme/colors.dart';
import '../utils.dart';

class CustomTextField extends StatelessWidget {
  final bool isPassword;
  final int maxlines;
  final int minLines;
  final bool isNumeric;
  final TextEditingController? controller;
  final bool readOnly;
  final EdgeInsets margin;
  final String? initialValue;
  final BorderRadius raduis;
  final int maxCharacters;
  final String hint;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? color;
  final bool isEnable;
  final bool isLabelFixed;
  final RxBool _isVisible = RxBool(false);
  late final TextInputType _inputType;

  CustomTextField(
      {Key? key,
      this.controller,
      this.hint = 'Type here...',
      this.isPassword = false,
      this.initialValue,
      this.maxlines = 1,
      required this.maxCharacters,
      this.minLines = 1,
      this.isNumeric = false,
      this.readOnly = false,
      this.margin = const EdgeInsets.all(0),
      TextInputType inputType = TextInputType.text,
      this.raduis = raduis_8,
      this.onTap,
      this.validator,
      this.onChanged,
      this.prefixIcon,
      this.suffixIcon,
      this.onSubmitted,
      this.color,
      this.isEnable = true,
      this.isLabelFixed = false})
      : super(key: key) {
    _isVisible(isPassword);
    _inputType = isPassword
        ? TextInputType.visiblePassword
        : isNumeric && !readOnly
            ? TextInputType.number
            : readOnly
                ? TextInputType.none
                : inputType;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Obx(
        () => TextFormField(
          // onFieldSubmitted: (s) => onSubmitted!(s),
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          cursorHeight: 22,
          cursorColor: kDefaultIconDarkColor,
          controller: controller,
          obscureText: _isVisible.value,
          validator: validator,
          onChanged: onChanged,
          readOnly: readOnly,
          maxLength: maxCharacters,
          onTap: onTap,
          initialValue: initialValue,
          enabled: isEnable,
          textCapitalization: _getFormate(_inputType),
          keyboardType: _inputType,
          inputFormatters:
              isNumeric ? [FilteringTextInputFormatter.digitsOnly] : null,
          style: AppStyle.normal,
          smartDashesType: SmartDashesType.enabled,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: isPassword
                ? InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      _isVisible.toggle();
                    },
                    child: Icon(
                      _isVisible.isFalse
                          ? CupertinoIcons.eye_slash_fill
                          : CupertinoIcons.eye_solid,
                      color: color ?? kDefaultIconDarkColor,
                      size: 24,
                    ),
                  )
                : suffixIcon,
            filled: true,
            contentPadding: getPadding(top: 20, bottom: 20, left: 16, right: 8),
            enabledBorder: OutlineInputBorder(
                borderRadius: raduis, borderSide: BorderSide.none),
            disabledBorder: OutlineInputBorder(
                borderRadius: raduis, borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: raduis, borderSide: BorderSide.none),
            errorBorder: OutlineInputBorder(
                borderRadius: raduis, borderSide: BorderSide(color: kRed)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: raduis, borderSide: BorderSide(color: kRed)),
            hintText: hint,
            hintStyle: AppStyle.normal,
            fillColor: color ?? kGrey,
            isDense: true,
          ),
        ),
      ),
    );
  }

  TextCapitalization _getFormate(TextInputType inputType) {
    if (inputType == TextInputType.name) {
      return TextCapitalization.words;
    } else if (inputType == TextInputType.text) {
      return TextCapitalization.sentences;
    } else {
      return TextCapitalization.none;
    }
  }
}


class CustomTextField1 extends StatelessWidget {
  final bool isPassword;
  final int maxlines;
  final int minLines;
  final bool isNumeric;
  final TextEditingController? controller;
  final bool readOnly;
  final EdgeInsets margin;
  final String? initialValue;
  final BorderRadius raduis;

  final String hint;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? color;
  final bool isEnable;
  final bool isLabelFixed;
  final RxBool _isVisible = RxBool(false);
  late final TextInputType _inputType;

  CustomTextField1(
      {Key? key,
        this.controller,
        this.hint = 'Type here...',
        this.isPassword = false,
        this.initialValue,
        this.maxlines = 1,

        this.minLines = 1,
        this.isNumeric = false,
        this.readOnly = false,
        this.margin = const EdgeInsets.all(0),
        TextInputType inputType = TextInputType.text,
        this.raduis = raduis_8,
        this.onTap,
        this.validator,
        this.onChanged,
        this.prefixIcon,
        this.suffixIcon,
        this.onSubmitted,
        this.color,
        this.isEnable = true,
        this.isLabelFixed = false})
      : super(key: key) {
    _isVisible(isPassword);
    _inputType = isPassword
        ? TextInputType.visiblePassword
        : isNumeric && !readOnly
        ? TextInputType.number
        : readOnly
        ? TextInputType.none
        : inputType;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Obx(
            () => TextFormField(
          // onFieldSubmitted: (s) => onSubmitted!(s),
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          cursorHeight: 22,
          cursorColor: kDefaultIconDarkColor,
          controller: controller,
          obscureText: _isVisible.value,
          validator: validator,
          onChanged: onChanged,
          readOnly: readOnly,

          onTap: onTap,
          initialValue: initialValue,
          enabled: isEnable,
          textCapitalization: _getFormate(_inputType),
          keyboardType: _inputType,
          inputFormatters:
          isNumeric ? [FilteringTextInputFormatter.digitsOnly] : null,
          style: AppStyle.normal,
          smartDashesType: SmartDashesType.enabled,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: isPassword
                ? InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {
                _isVisible.toggle();
              },
              child: Icon(
                _isVisible.isFalse
                    ? CupertinoIcons.eye_slash_fill
                    : CupertinoIcons.eye_solid,
                color: color ?? kDefaultIconDarkColor,
                size: 24,
              ),
            )
                : suffixIcon,
            filled: true,
            contentPadding: getPadding(top: 20, bottom: 20, left: 16, right: 8),
            enabledBorder: OutlineInputBorder(
                borderRadius: raduis, borderSide: BorderSide.none),
            disabledBorder: OutlineInputBorder(
                borderRadius: raduis, borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: raduis, borderSide: BorderSide.none),
            errorBorder: OutlineInputBorder(
                borderRadius: raduis, borderSide: BorderSide(color: kRed)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: raduis, borderSide: BorderSide(color: kRed)),
            hintText: hint,
            hintStyle: AppStyle.normal,
            fillColor: color ?? kGrey,
            isDense: true,
          ),
        ),
      ),
    );
  }

  TextCapitalization _getFormate(TextInputType inputType) {
    if (inputType == TextInputType.name) {
      return TextCapitalization.words;
    } else if (inputType == TextInputType.text) {
      return TextCapitalization.sentences;
    } else {
      return TextCapitalization.none;
    }
  }
}
