import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kaydi_mobile/core/base/state.dart';

class BaseView<T> extends StatefulWidget {
  final Widget Function(BuildContext context) builder;
  final VoidCallback? onDispose;

  const BaseView({Key? key, required this.builder, this.onDispose}) : super(key: key);

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T> extends BaseState<BaseView<T>> {
  @override
  void dispose() {
    super.dispose();

    if (widget.onDispose != null) widget.onDispose!();
  }

  void buildPageBefore() async {
    Future.delayed(Duration.zero, () {
      FocusScope.of(context).unfocus();
    });
    
  }

  @override
  void initState() {
    buildPageBefore();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}
