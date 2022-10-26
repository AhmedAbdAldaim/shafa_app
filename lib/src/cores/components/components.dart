import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:medical_app/src/cores/mediquery/app_mediquery.dart';
import 'package:shimmer/shimmer.dart';

Widget defaultTextFormFaield(
    {required TextEditingController controller,
    required TextInputType type,
    required String hint,
    required TextInputAction action,
    required FormFieldValidator valid,
    bool ispassword = false,
    Icon? suffixicon,
    Icon? preficon,
    VoidCallback? changepassword,
    ValueChanged<String>? onFieldSubmitted,
    required BuildContext context}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    style: TextStyle(fontSize: AppMediaQuery.width(context: context) * 0.04),
    decoration: InputDecoration(
        hintText: hint,
        hintStyle:
            TextStyle(fontSize: AppMediaQuery.width(context: context) * 0.04),
        contentPadding: EdgeInsets.symmetric(
            horizontal: AppMediaQuery.width(context: context) * 0.04),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              AppMediaQuery.width(context: context) * 0.02),
        ),
        prefixIcon: preficon,
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                AppMediaQuery.width(context: context) * 0.02),
            borderSide: BorderSide(color: Colors.red.shade800)),
        suffixIcon: suffixicon != null
            ? IconButton(onPressed: changepassword, icon: suffixicon)
            : null),
    obscureText: ispassword,
    validator: valid,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    textInputAction: action,
    onFieldSubmitted: onFieldSubmitted,
  );
}

Widget defaultSearch(
    {required ValueChanged onChange,
    required String hint,
    required TextInputType type,
    required TextInputAction action,
    required TextEditingController controller}) {
  return TextFormField(
    onChanged: onChange,
    controller: controller,
    decoration: InputDecoration(
        hintText: hint,
        
        prefixIcon: const Icon(
          Icons.search_rounded,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
        border: const OutlineInputBorder()),
    keyboardType: type,
    textInputAction: action,
  );
}

Widget defaultButton(
        {required BuildContext context,
        required String title,
        required Color colorTitle,
        required Color colorBtn,
        required VoidCallback onPressed}) =>
    ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            primary: colorBtn,
            padding:
                EdgeInsets.all(AppMediaQuery.width(context: context) * 0.02),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  AppMediaQuery.width(context: context) * 0.02),
            )),
        child: Text(title,
            style: TextStyle(
                fontSize: AppMediaQuery.width(context: context) * 0.03,
                fontWeight: FontWeight.bold,
                color: colorTitle)));

defaultAlerDialog(
    {required BuildContext context,
    required String title,
    required String content,
    required String ok,
    required VoidCallback? btnOk,
    required VoidCallback? btnCancle,
    required String cancle}) {
  return showDialog(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Builder(builder: (context) {
              return SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(content),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                              child: TextButton(
                                  onPressed: btnOk, child: Text(ok))),
                          Expanded(
                              child: TextButton(
                                  onPressed: btnCancle, child: Text(cancle)))
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
          ),
        );
      });
}

//appBar
defaultappBar({
  required BuildContext context,
  String? title,
  double? elevation,
  Color? color,
}) {
  return AppBar(
    title: Text(title ?? '', style: Theme.of(context).textTheme.titleMedium),
    centerTitle: true,
    elevation: elevation ?? 3.0,
    backgroundColor: color,
  );
}

//listTile
defaultListTitle(
    {required Widget title,
    Widget? leading,
    Widget? trailing,
    Widget? subtilte,
    double? minLeadingWidth,
    EdgeInsetsGeometry? contentPadding,
    GestureTapCallback? onTap}) {
  return ListTile(
    leading: leading,
    minLeadingWidth: minLeadingWidth,
    contentPadding: contentPadding,
    title: title,
    trailing: trailing,
    subtitle: subtilte,
    onTap: onTap,
  );
}

defaultSnakbar(
    {required String content, required BuildContext context, Color? color}) {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Flushbar(
      messageText: Text(
        content,
        textAlign: TextAlign.right,
        style:  TextStyle(
          fontSize: AppMediaQuery.width(context: context)*0.04,
          color: Colors.white),
      ),
      duration: const Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: color ?? Colors.red.shade900,
      textDirection: TextDirection.rtl,
      padding: EdgeInsets.all(AppMediaQuery.width(context: context) * 0.03),
      borderRadius: BorderRadius.circular(AppMediaQuery.width(context: context) * 0.0),
    )..show(context),
  );
}

Shimmer defaultShimmer({required Widget child}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    direction: ShimmerDirection.rtl,
    child: child,
  );
}

Widget checkServer({required context, required VoidCallback onPressed}) =>
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            size: 30,
            color: Colors.red,
          ),
          const SizedBox(
            height: 2.0,
          ),
          const Text('هناك خطأ في الإتصال بالخادم!',
              style: TextStyle(color: Colors.black)),
          const SizedBox(
            height: 3.0,
          ),
          ElevatedButton(
              onPressed: onPressed, child: const Text('حاول مرة اخرى'))
        ],
      ),
    );
