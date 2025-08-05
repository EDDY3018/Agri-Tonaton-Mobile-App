import 'package:agri_tonaton/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final Key? fieldKey;
  final String? hintText, labelText, validateMsg;
  final FormFieldSetter<String>? onSaved;
  final bool? validate, removeBorder, showBorderRound;
  final IconData? prefixIcon;
  final ValueChanged<String>? onFieldSubmitted;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final double? borderRadius, borderWidth, height;
  final Color? borderColor;

  const PasswordField({
    super.key,
    this.fieldKey,
    @required this.hintText,
    this.onSaved,
    this.validate = true,
    this.removeBorder = false,
    this.onFieldSubmitted,
    this.labelText,
    @required this.controller,
    @required this.validateMsg,
    @required this.focusNode,
    this.prefixIcon,
    this.borderWidth,
    this.borderRadius = 4,
    this.showBorderRound = true,
    this.borderColor = WHITE,
    this.height = 15,
    required Null Function() onTap, // Optional - remove if unused
    onEditingComplete, // Optional - remove if unused
  });

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(widget.borderRadius ?? 4);
    final borderSide = BorderSide(
      color: widget.borderColor ?? WHITE,
      width: widget.borderWidth ?? 0.1,
    );

    return TextFormField(
      keyboardType: TextInputType.text,
      key: widget.fieldKey,
      obscureText: _obscureText,
      onSaved: widget.onSaved,
      focusNode: widget.focusNode,
      validator: (value) {
        if ((value == null || value.isEmpty) && widget.validate!) {
          return widget.validateMsg;
        }
        return null;
      },
      onFieldSubmitted: widget.onFieldSubmitted,
      style: const TextStyle(color: PRIMARY, fontWeight: FontWeight.w400),
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          color: TEXTFIELD,
          fontSize: 13,
          fontWeight: FontWeight.normal,
        ),
        labelText: widget.labelText,
        labelStyle: const TextStyle(color: BLACK),
        filled: true,
        fillColor: WHITE,
        contentPadding: EdgeInsets.symmetric(
          vertical: widget.height ?? 15,
          horizontal: 10,
        ),
        prefixIcon: widget.prefixIcon == null
            ? null
            : Icon(widget.prefixIcon, color: WHITE),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: borderSide,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: borderSide,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            color: WHITE,
            width: widget.borderWidth ?? 0.1,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: borderSide,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: PRIMARY,
          ),
        ),
      ),
    );
  }
}
