import 'package:flutter/material.dart';
import 'package:library_user_app/utils/app_color.dart';
import 'package:library_user_app/utils/dimensions.dart';
import 'package:library_user_app/utils/styles.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final int maxLines;
  final bool isPassword;
  final Function? onTap;
  final Function? onChanged;
  final Function? onSubmit;
  final bool isMarginEnable;
  final String? Function(String? value)? validator;
  final AutovalidateMode? autoValidateMode;
  final String? titleText;
  final bool showTitle;
  final bool isRequired;
  final String? labelText;

  const CustomTextField({
    super.key,
    this.isPassword = false,
    this.hintText = '',
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.maxLines = 1,
    this.onTap,
    this.onChanged,
    this.onSubmit,
    this.isMarginEnable = false,
    this.validator,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.titleText,
    this.showTitle = true,
    this.isRequired = false,
    this.labelText,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45 * double.parse(widget.maxLines.toString()),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radiusFive),
          color: AppColor.white,
        ),
        child: TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          keyboardType: widget.inputType,
          textInputAction: widget.inputAction,
          maxLines: widget.maxLines,
          obscureText: widget.isPassword ? _obscureText : false,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            hintStyle: robotoRegular.copyWith(color: Colors.grey),
            hintText: widget.hintText,
            contentPadding: const EdgeInsets.all(Dimensions.paddingSizeFifteen),
            focusedBorder: border(),
            enabledBorder: border(),
            disabledBorder: border(),
            focusedErrorBorder: border(),
            errorBorder: border(),
            suffixIcon:  widget.isPassword ? IconButton(
              icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility, color: AppColor.grey),
              onPressed: _toggle,
            ) : null,
            labelText: widget.labelText,
            labelStyle: robotoRegular.copyWith(color: AppColor.grey),
          ),
          onTap: widget.onTap as void Function()?,
          onSaved: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus) : widget.onSubmit != null ? widget.onSubmit!(text) : null,
          onChanged: widget.onChanged as void Function(String)?,
          validator: widget.validator,
          autovalidateMode: widget.autoValidateMode,
        ),
      ),
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  OutlineInputBorder border ({Color color = AppColor.grey}) {

    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusFive)),
      borderSide: BorderSide(width: 1, color: color),
    );
  }

}
