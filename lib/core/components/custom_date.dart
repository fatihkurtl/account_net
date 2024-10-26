import 'package:flutter/material.dart';

class CustomDateField extends StatefulWidget {
  final String hintText;
  final DateTime? selectedDate;
  final Function(DateTime?)? onChanged;

  const CustomDateField({
    super.key,
    required this.hintText,
    this.selectedDate,
    this.onChanged,
  });

  @override
  State<CustomDateField> createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: GestureDetector(
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: widget.selectedDate ?? DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );

          if (pickedDate != null && widget.onChanged != null) {
            widget.onChanged!(pickedDate);
          }
        },
        child: AbsorbPointer(
          child: TextField(
            readOnly: true, // TextField'ı yalnızca okunur hale getiriyoruz
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(12),
              ),
              fillColor: Colors.grey.shade200,
              filled: true,
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: Colors.grey[500],
              ),
              suffixIcon: const Icon(Icons.calendar_today, color: Colors.grey),
            ),
            controller: TextEditingController(
              text: widget.selectedDate != null ? '${widget.selectedDate?.toLocal()}'.split(' ')[0] : '',
            ),
          ),
        ),
      ),
    );
  }
}
