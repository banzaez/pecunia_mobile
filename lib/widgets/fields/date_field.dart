import 'package:flutter/material.dart';
import 'package:pecunia/util/ext_datetime.dart';
import 'package:pecunia/widgets/fields/base_field.dart';

class DateField extends StatefulWidget {
  final DateTime initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  final String? hintText;
  final bool showLabel;

  final ValueChanged<DateTime?> onChange;

  const DateField({
    super.key,
    required this.onChange,
    this.hintText,
    this.showLabel = true,
    required this.initialDate,
    this.firstDate,
    this.lastDate,
  });

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  final controller = TextEditingController();
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
    controller.text = selectedDate.formatDDMMYYYY;
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => _onTap(context),
        child: AbsorbPointer(
          child: BaseField(
            controller: controller,
            hintText: widget.hintText,
            showLabel: widget.showLabel,
          ),
        ),
      );

  Future<void> _onTap(context) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: widget.firstDate ?? DateTime(2020),
      lastDate: widget.lastDate ?? DateTime.now(),
    );
    if (date != null) {
      setState(() => selectedDate = date);
    }

    controller.text = selectedDate.formatDDMMYYYY;

    widget.onChange(date);
  }
}
