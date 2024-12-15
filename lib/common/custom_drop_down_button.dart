import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:library_user_app/utils/app_color.dart';
import 'package:library_user_app/utils/dimensions.dart';
import 'package:library_user_app/utils/styles.dart';

class CustomDropdownButton extends StatefulWidget {
  final List<String>? items;
  final String? titleText;
  final bool showTitle;
  final bool isRequired;
  final String? hintText;
  final Function(String?)? onChanged;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final FontWeight? titleFontWeight;
  final String? selectedValue;
  final List<DropdownMenuItem<String>>? dropdownMenuItems;

  const CustomDropdownButton({
    super.key,
    this.items,
    this.titleText,
    this.showTitle = true,
    this.isRequired = false,
    this.hintText,
    this.onChanged,
    this.validator,
    this.onSaved,
    this.titleFontWeight,
    this.selectedValue,
    this.dropdownMenuItems,
  });

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: DropdownButtonFormField2<String>(

              isExpanded: true,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeTen),
                focusedBorder: _border(),
                enabledBorder: _border(),
                disabledBorder: _border(),
                focusedErrorBorder: _border(),
                errorBorder: _border(),
              ),
              hint: Text(
                widget.hintText ?? 'Select an option',
                style: robotoRegular.copyWith(color: Colors.grey),
              ),
              value: widget.selectedValue,
              items: (widget.dropdownMenuItems ?? widget.items?.map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item, style: robotoRegular,
                ),
              )).toList()) ?? [
                DropdownMenuItem<String>(
                  value: null,
                  child: Text(
                    'No data found',
                    style: robotoRegular.copyWith(color: Colors.grey),
                  ),
                )
              ],
              validator: widget.validator ?? (value) {
                if (value == null) {
                  return 'Please select an option.';
                }
                return null;
              },
              onChanged: widget.onChanged,
              onSaved: widget.onSaved,
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.only(right: 8),
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(Icons.arrow_drop_down, color: AppColor.grey, size: 30),
              ),
              dropdownStyleData: DropdownStyleData(
                maxHeight: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radiusFive),
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder _border({Color color = AppColor.grey}) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      borderSide: BorderSide(width: 1, color: color),
    );
  }
}