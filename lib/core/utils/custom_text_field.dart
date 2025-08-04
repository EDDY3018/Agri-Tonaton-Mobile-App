import 'package:agri_tonaton/core/utils/app_colors.dart';
import 'package:agri_tonaton/core/utils/properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/services/text_formatter.dart';

Widget textFormField({
  Function()? function,
  @required String? hintText,
  String? labelText,
  String? validateMsg,
  IconData? icon,
  IconData? prefixIcon,
  Color iconColor = WHITE,
  Color prefixIconColor = WHITE,
  Color? cursorColor,
  Color textColor = PRIMARY,
  Color labelColor = WHITE,
  Color backgroundColor = WHITE,
  @required TextEditingController? controller,
  bool validate = true,
  bool suggestion = false,
  TextInputType inputType = TextInputType.text,
  int? maxLine = 1,
  int? minLine = 1,
  bool validateEmail = false,
  double? width,
  enable = true,
  bool removeBorder = false,
  void Function()? onIconTap,
  TextInputAction? inputAction,
  void Function()? onEditingComplete,
  void Function(String text)? onTextChange,
  @required FocusNode? focusNode,
  bool readOnly = false,
  bool showBorderRound = true,
  Color borderColor = WHITE,
  TextCapitalization textCapitalization = TextCapitalization.sentences,
  int? maxLength,
  double borderWidth = 0.1,
  double borderRadius = 8,
  bool isDense = false,
  double? height = 0,
  required TextStyle labelStyle,
  required TextInputType keyboardType,
  required List<TextInputFormatter> inputFormatters,
  required Null Function() onTap,
}) {
  return SizedBox(
    width: width,
    child: TextFormField(
      onTap: function,
      readOnly: readOnly,
      enableInteractiveSelection: true,
      enabled: enable,
      enableSuggestions: suggestion,
      keyboardType: inputType,
      controller: controller,
      minLines: minLine,
      maxLines: maxLine,
      maxLength: maxLength,
      focusNode: focusNode,
      autofocus: false,
      textInputAction: inputAction,
      cursorColor: cursorColor,
      textCapitalization:
          validateEmail ? TextCapitalization.none : textCapitalization,
      style: TextStyle(color: textColor, fontWeight: FontWeight.w400),
      onEditingComplete: () {
        focusNode!.unfocus();
        // onEditingComplete();
      },
      onChanged: onTextChange == null ? null : (text) => onTextChange(text),
      decoration: InputDecoration(
        contentPadding: height == null
            ? const EdgeInsets.symmetric(vertical: 15, horizontal: 10)
            : EdgeInsets.symmetric(vertical: height, horizontal: 10),
        isDense: isDense,
        hintText: hintText,
        hintStyle: const TextStyle(
            color: TEXTFIELD, fontSize: 13, fontWeight: FontWeight.normal),
        labelText: labelText,
        labelStyle: TextStyle(color: labelColor),
        filled: true,
        fillColor: backgroundColor,
        suffixIcon: icon == null
            ? null
            : GestureDetector(
                onTap: onIconTap,
                child: Icon(icon, color: iconColor),
              ),
        prefixIcon: prefixIcon == null
            ? null
            : Icon(prefixIcon, color: prefixIconColor),
        enabledBorder: removeBorder
            ? InputBorder.none
            : showBorderRound
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide(
                      color: borderColor,
                      width: borderWidth,
                    ),
                  )
                : UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: borderColor,
                      width: borderWidth,
                    ),
                  ),
        disabledBorder: removeBorder
            ? InputBorder.none
            : showBorderRound
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide(
                      color: borderColor,
                      width: borderWidth,
                    ),
                  )
                : UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: borderColor,
                      width: borderWidth,
                    ),
                  ),
        focusedBorder: removeBorder
            ? InputBorder.none
            : showBorderRound
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide(
                      color: WHITE,
                      width: borderWidth,
                    ),
                  )
                : UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: WHITE,
                      width: borderWidth,
                    ),
                  ),
        border: removeBorder
            ? InputBorder.none
            : showBorderRound
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide(
                      color: borderColor,
                      width: borderWidth,
                    ),
                  )
                : UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: borderColor,
                      width: borderWidth,
                    ),
                  ),
        errorStyle: const TextStyle(
          color: Colors.red,
        ),
      ),
      validator: (value) {
        RegExp regex = RegExp(PATTERN);
        if (value!.isEmpty && validate) {
          return validateMsg;
        } else if (validateEmail && !regex.hasMatch(value)) {
          return "Please enter a valid email address";
        }
        return null;
      },
    ),
  );
}
