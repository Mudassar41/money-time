import 'dart:async';
import 'package:flutter/material.dart';

mixin FormStateMixin<T extends StatefulWidget> on State<T> {
  final formKey = GlobalKey<FormState>();
  var autoValidateMode = AutovalidateMode.disabled;

  void submitter() {
    if (!formKey.currentState!.validate()) {
      autoValidateMode = AutovalidateMode.onUserInteraction;
      setState(() {});
      return;
    }
    formKey.currentState?.save();
    FocusManager.instance.primaryFocus!.unfocus();
    onSubmit();
  }

  FutureOr<void> onSubmit() {}
}
