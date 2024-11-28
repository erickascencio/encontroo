import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:encontroo/utils/validators.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Buttons {
  static Widget buildLabeledTextField(
    String label,
    TextEditingController controller,
    String? Function(String?) validator, {
    Widget? suffixIcon,
    List<TextInputFormatter>? inputFormatters,
    MaskTextInputFormatter? maskFormatter,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: const Color(0xFF6B09B5), fontSize: 12.sp),
          ),
          SizedBox(height: 4.h),
          TextFormField(
            controller: controller,
            validator: (value) =>
                maskFormatter != null ? validator(maskFormatter.getMaskedText()) : validator(value),
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: label,
              hintStyle: TextStyle(color: Colors.grey, fontSize: 12.sp),
              suffixIcon: suffixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildLabeledDropdownField(
    BuildContext context,
    String label,
    List<String> items,
    String? value,
    String? Function(String?)? validator,
    ValueChanged<String?> onChanged,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: const Color(0xFF6B09B5), fontSize: 12.sp),
          ),
          SizedBox(height: 4.h),
          DropdownButtonFormField<String>(
            value: value,
            validator: validator,
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: TextStyle(fontSize: 12.sp)),
              );
            }).toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildLabeledDatePickerField(
    BuildContext context,
    String label,
    TextEditingController controller,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: const Color(0xFF6B09B5), fontSize: 12.sp),
          ),
          SizedBox(height: 4.h),
          TextFormField(
            controller: controller,
            validator: Validators.validateDateOfBirth,
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                locale: const Locale('pt', 'BR'), // Define o idioma como PT-BR
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(
                        primary: const Color(0xFF6B09B5), // Header color
                        onPrimary: Colors.white, // Header text color
                        onSurface: const Color(0xFF6B09B5), // Body text color
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF6B09B5),
                        ),
                      ),
                    ),
                    child: child!,
                  );
                },
              );

              if (pickedDate != null) {
                // Formata a data em PT-BR
                controller.text = DateFormat('dd/MM/yyyy').format(pickedDate);
              }
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: label,
              hintStyle: TextStyle(color: Colors.grey, fontSize: 12.sp),
              suffixIcon: const Icon(Icons.calendar_today, color: Color(0xFF6B09B5)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
