import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateField extends StatefulWidget {
  final String hintText;
  final DateTime? selectedDate;
  final EdgeInsets? padding;
  final Function(DateTime?)? onChanged;

  const CustomDateField({
    super.key,
    required this.hintText,
    this.selectedDate,
    this.padding = const EdgeInsets.symmetric(horizontal: 25.0),
    this.onChanged,
  });

  @override
  State<CustomDateField> createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _updateDateDisplay();
  }

  @override
  void didUpdateWidget(CustomDateField oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateDateDisplay();
  }

  void _updateDateDisplay() {
    _controller.text = widget.selectedDate != null ? DateFormat('dd/MM/yyyy').format(widget.selectedDate!) : '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 25.0),
      child: GestureDetector(
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: widget.selectedDate ?? DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                    onSurface: Colors.black,
                  ),
                  dialogBackgroundColor: Colors.lightGreen.shade100,
                ),
                child: child!,
              );
            },
          );

          if (pickedDate != null && widget.onChanged != null) {
            widget.onChanged!(pickedDate);
            _controller.text = DateFormat('dd/MM/yyyy').format(pickedDate);
          }
        },
        child: AbsorbPointer(
          child: TextField(
            controller: _controller,
            readOnly: true,
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
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
