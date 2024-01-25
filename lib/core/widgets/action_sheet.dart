import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//****For call ***/
//Example//
/*
        showAdaptiveActionSheet(
          context: context,
          title: const Text('Action Sheet'),
          androidBorderRadius: 30,
          actions: [
            BottomSheetAction(title: const Text('Item 1'), onPressed: () {}),
            BottomSheetAction(title: const Text('Item 2'), onPressed: () {}),
            BottomSheetAction(title: const Text('Item 3'), onPressed: () {}),
          ],
          cancelAction: CancelAction(title: const Text('Cancel')),
        ); 
*/

Future<T?> showAdaptiveActionSheet<T>({
  required BuildContext context,
  Widget? title,
  required List<BottomSheetAction> actions,
  CancelAction? cancelAction,
  Color? barrierColor,
  Color? bottomSheetColor,
  double? androidBorderRadius,
  bool isDismissible = true,
}) async {
  assert(
    barrierColor != Colors.transparent,
    'The barrier color cannot be transparent.',
  );

  return _show<T>(
    context,
    title,
    actions,
    cancelAction,
    barrierColor,
    bottomSheetColor,
    androidBorderRadius,
    isDismissible: isDismissible,
  );
}

Future<T?> _show<T>(
  BuildContext context,
  Widget? title,
  List<BottomSheetAction> actions,
  CancelAction? cancelAction,
  Color? barrierColor,
  Color? bottomSheetColor,
  double? androidBorderRadius, {
  bool isDismissible = true,
}) {
  if (Platform.isIOS) {
    return _showCupertinoBottomSheet(
      context,
      title,
      actions,
      cancelAction,
      isDismissible: isDismissible,
    );
  } else {
    return _showMaterialBottomSheet(
      context,
      title,
      actions,
      cancelAction,
      barrierColor,
      bottomSheetColor,
      androidBorderRadius,
      isDismissible: isDismissible,
    );
  }
}

Future<T?> _showCupertinoBottomSheet<T>(
  BuildContext context,
  Widget? title,
  List<BottomSheetAction> actions,
  CancelAction? cancelAction, {
  bool isDismissible = true,
}) {
  final defaultTextStyle =
      Theme.of(context).textTheme.titleLarge ?? const TextStyle(fontSize: 20);
  return showCupertinoModalPopup(
    context: context,
    barrierDismissible: isDismissible,
    builder: (BuildContext coxt) {
      return CupertinoActionSheet(
        title: title,
        actions: actions.map((action) {
          return Material(
            color: Colors.transparent,
            child: CupertinoActionSheetAction(
              onPressed: action.onPressed,
              child: Row(
                children: [
                  if (action.leading != null) ...[
                    action.leading!,
                    const SizedBox(width: 15),
                  ],
                  Expanded(
                    child: DefaultTextStyle(
                      style: defaultTextStyle,
                      textAlign: action.leading != null
                          ? TextAlign.start
                          : TextAlign.center,
                      child: action.title,
                    ),
                  ),
                  if (action.trailing != null) ...[
                    const SizedBox(width: 10),
                    action.trailing!,
                  ],
                ],
              ),
            ),
          );
        }).toList(),
        cancelButton: cancelAction != null
            ? CupertinoActionSheetAction(
                onPressed:
                    cancelAction.onPressed ?? () => Navigator.of(coxt).pop(),
                child: DefaultTextStyle(
                  style: defaultTextStyle.copyWith(color: Colors.lightBlue),
                  textAlign: TextAlign.center,
                  child: cancelAction.title,
                ),
              )
            : null,
      );
    },
  );
}

Future<T?> _showMaterialBottomSheet<T>(
  BuildContext context,
  Widget? title,
  List<BottomSheetAction> actions,
  CancelAction? cancelAction,
  Color? barrierColor,
  Color? bottomSheetColor,
  double? androidBorderRadius, {
  bool isDismissible = true,
}) {
  final defaultTextStyle =
      Theme.of(context).textTheme.titleLarge ?? const TextStyle(fontSize: 20);
  final BottomSheetThemeData sheetTheme = Theme.of(context).bottomSheetTheme;
  return showModalBottomSheet<T>(
    context: context,
    elevation: 0,
    isDismissible: isDismissible,
    enableDrag: isDismissible,
    isScrollControlled: true,
    backgroundColor: bottomSheetColor ??
        sheetTheme.modalBackgroundColor ??
        sheetTheme.backgroundColor,
    barrierColor: barrierColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(androidBorderRadius ?? 30),
        topRight: Radius.circular(androidBorderRadius ?? 30),
      ),
    ),
    builder: (BuildContext coxt) {
      final double screenHeight = MediaQuery.of(context).size.height;
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: screenHeight - (screenHeight / 10),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (title != null) ...[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(child: title),
                ),
              ],
              ...actions.map<Widget>((action) {
                return InkWell(
                  onTap: action.onPressed,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        if (action.leading != null) ...[
                          action.leading!,
                          const SizedBox(width: 15),
                        ],
                        Expanded(
                          child: DefaultTextStyle(
                            style: defaultTextStyle,
                            textAlign: action.leading != null
                                ? TextAlign.start
                                : TextAlign.center,
                            child: action.title,
                          ),
                        ),
                        if (action.trailing != null) ...[
                          const SizedBox(width: 10),
                          action.trailing!,
                        ],
                      ],
                    ),
                  ),
                );
              }).toList(),
              if (cancelAction != null)
                InkWell(
                  onTap:
                      cancelAction.onPressed ?? () => Navigator.of(coxt).pop(),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: DefaultTextStyle(
                        style:
                            defaultTextStyle.copyWith(color: Colors.lightBlue),
                        textAlign: TextAlign.center,
                        child: cancelAction.title,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    },
  );
}

class BottomSheetAction {
  final Widget title;
  final VoidCallback onPressed;
  final Widget? trailing;
  final Widget? leading;
  BottomSheetAction({
    required this.title,
    required this.onPressed,
    this.trailing,
    this.leading,
  });
}

class CancelAction {
  final Widget title;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;
  CancelAction({
    required this.title,
    this.onPressed,
    this.textStyle,
  });
}
