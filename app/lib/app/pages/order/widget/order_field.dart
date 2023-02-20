// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/app/core/ui/styles/text_styles.dart';
import 'package:flutter/material.dart';

class OrderField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final FormFieldValidator validator;

  const OrderField({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    const defaultBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 35,
            child: Text(
              title,
              style: context.textStyle.textRegular.copyWith(
                fontSize: 16,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          TextFormField(
            controller: controller,
            validator: validator,
            decoration: InputDecoration(
              hintText: hintText,
              border: defaultBorder,
              enabledBorder: defaultBorder,
              errorBorder: defaultBorder,
            ),
          )
        ],
      ),
    );
  }
}
