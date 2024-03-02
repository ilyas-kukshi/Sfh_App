import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppThemeShared {
  static Color primaryColor = const Color(0xff439A97);
  static Color secondaryColor = const Color(0xff62B6B7);
  static Color tertiartyColor = const Color(0xff97DECE);

  static Color textColor = const Color(0xff0D1B2A);

  static appBar(
      {required String title,
      required BuildContext context,
      bool automaticallyImplyLeading = false,
      bool? centerTitle = true,
      Widget? leading,
      bool backButton = true,
      List<Widget>? actions,
      Color? backgroundColor = const Color(0xff439A97),
      double textSize = 26,
      Color textColor = Colors.white,
      TextStyle textStyle = const TextStyle(
          fontSize: 18,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
          color: Colors.white),
      FontWeight fontWeight = FontWeight.w600}) {
    return AppBar(
      title: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: textStyle,
      ),
      automaticallyImplyLeading: false,
      centerTitle: centerTitle,
      leading: leading ??
          (backButton
              ? GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                )
              : const Offstage()),
      actions: actions,
      backgroundColor: backgroundColor,
    );
  }

  static sharedButton({
    required BuildContext context,
    double height = 60,
    bool percent = false,
    double widthPercent = 0.9,
    double width = 300,
    Color color = const Color(0xff62B6B7),
    required String buttonText,
    required dynamic Function()? onTap,
    double borderRadius = 0.0,
    double borderWidth = 0.0,
    double elevation = 0.0,
    // double textSize = 16,
    TextStyle textStyle = const TextStyle(color: Colors.white),
    Color textColor = Colors.white,
    FontWeight fontWeight = FontWeight.w600,
    Color borderColor = Colors.transparent,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          fixedSize: Size(
              percent
                  ? MediaQuery.of(context).size.width * widthPercent
                  : width,
              height),
          backgroundColor: color,
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          side: BorderSide(color: borderColor, width: borderWidth)),
      onPressed: onTap,
      child: Text(buttonText, style: textStyle),
    );

    // return ElevatedButton(
    //     onPressed: onPressed,
  }

  static textFormField(
      {required BuildContext context,
      String labelText = '',
      String hintText = '',
      String? initialValue,
      String prefixText = '',
      String? suffixText,
      TextEditingController? controller,
      TextInputAction? textInputAction,
      TextInputType? keyboardType,
      AutovalidateMode? autovalidateMode,

      //
      EdgeInsetsGeometry contentPadding = const EdgeInsets.all(14),

      //
      String? Function(String?)? validator,
      void Function(String)? onChanged,
      void Function(String?)? onSaved,
      void Function()? onEditingComplete,
      void Function(String)? onFieldSubmitted,
      void Function()? onTap,
      List<TextInputFormatter>? inputFormatters,

      //
      bool obscureText = false,
      bool autoFocus = false,
      bool readonly = false,
      bool expands = false,
      bool enabled = false,

      //
      int? maxLines,
      int? minLines,
      double borderRadius = 0,
      double enabledBorderWidth = 2,

      //
      Color enabledBorderColor = Colors.cyan,
      Color focusedBorderColor = const Color(0xff439A97),
      Color borderColor = const Color(0xff439A97),
      Color disabledBorderColor = const Color(0xff439A97),

      //
      Widget? suffix,
      Widget? suffixIcon,
      Widget? prefixIcon,
      bool widthPixel = false,
      double? width = 200,
      double widthPercent = 0.85}) {
    return SizedBox(
      width:
          widthPixel ? width : MediaQuery.of(context).size.width * widthPercent,
      child: TextFormField(
        controller: controller,
        validator: validator,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        initialValue: initialValue,
        obscureText: obscureText,
        autofocus: autoFocus,
        readOnly: readonly,
        expands: expands,
        enabled: true,
        maxLines: maxLines,
        minLines: minLines,
        autovalidateMode: autovalidateMode,
        onChanged: onChanged,
        onSaved: onSaved,
        onEditingComplete: onEditingComplete,
        onFieldSubmitted: onFieldSubmitted,
        onTap: onTap,
        inputFormatters: inputFormatters,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 16),
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: contentPadding,
          hintText: hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(color: Colors.black.withOpacity(0.5)),
          labelText: labelText,
          labelStyle: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(color: AppThemeShared.primaryColor),
          suffix: suffix,
          suffixText: suffixText,
          suffixIcon: suffixIcon,
          isDense: true,
          prefixText: prefixText,
          prefixIcon: prefixIcon,
          prefixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide:
                  BorderSide(color: borderColor, width: enabledBorderWidth)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                  color: AppThemeShared.secondaryColor,
                  width: enabledBorderWidth)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                  color: focusedBorderColor, width: enabledBorderWidth)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(color: disabledBorderColor)),
        ),
      ),
    );
  }

  static sharedRaisedButton({
    required BuildContext context,
    required double height,
    required double width,
    required Color color,
    required String buttonText,
    required void Function()? onPressed,
    double borderRadius = 0.0,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(height: height, width: width),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: color),
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  static sharedDropDown({
    required BuildContext context,
    required List<String> items,
    required void Function(String?) onChanged,
    double? height = 50,
    double? width = 200,
    double widthPercent = 0.85,
    bool widthPixel = false,
    Widget? hint,
    String? value,
    String? labelText,
    Color hintColor = const Color(0xff439A97),
    Color borderColor = const Color(0xff439A97),

    //
    double borderRadius = 0,
    double enabledBorderWidth = 2,
    //
    Color enabledBorderColor = Colors.cyan,
    Color focusedBorderColor = const Color(0xff439A97),
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),

      width:
          widthPixel ? width : MediaQuery.of(context).size.width * widthPercent,
      // decoration: BoxDecoration(
      //     border: Border.all(color: AppThemeShared.secondaryColor, width: 2)),
      child: DropdownButtonFormField(
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle:
                TextStyle(fontSize: 16, color: AppThemeShared.primaryColor),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                    color: AppThemeShared.secondaryColor,
                    width: enabledBorderWidth)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                    color: AppThemeShared.secondaryColor,
                    width: enabledBorderWidth)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                    color: focusedBorderColor, width: enabledBorderWidth)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: const BorderSide(color: Colors.black)),
          ),
          hint: hint,
          isExpanded: true,
          value: value,
          items: items.map((String item) {
            return DropdownMenuItem(value: item, child: Text(item.toString()));
          }).toList(),
          onChanged: onChanged),
    );
  }
}
