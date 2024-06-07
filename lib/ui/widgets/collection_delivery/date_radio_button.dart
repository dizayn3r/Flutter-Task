import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRadioButton extends StatefulWidget {
  final DateTime value;
  final DateTime groupValue;
  final Color? unselectedColor;
  final Color? selectedColor;
  final Function(DateTime)? onChanged;

  const DateRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    this.selectedColor,
    this.unselectedColor,
    this.onChanged,
  });

  @override
  State<DateRadioButton> createState() => _DateRadioButtonState();
}

class _DateRadioButtonState extends State<DateRadioButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        bool selected = widget.value != widget.groupValue;
        if (selected) {
          widget.onChanged!(widget.groupValue);
        }
      },
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.value == widget.groupValue
                ? [Colors.blue.shade400, Colors.blue.shade800]
                : [Colors.white, Colors.white],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(2, 2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              getDateTitle(widget.groupValue),
              style: TextStyle(
                color: widget.value == widget.groupValue ? Colors.white : Colors.grey.shade900,
              ),
            ),
            Text(
              DateFormat("dd MMM").format(widget.groupValue),
              style: TextStyle(
                color: widget.value == widget.groupValue ? Colors.white : Colors.grey.shade900,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

getDateTitle(DateTime time) {
  DateTime today = DateTime.now();
  DateTime tomorrow = today.add(const Duration(days: 1));
  String date = DateFormat("dd").format(time);
  if (date == DateFormat("dd").format(today)) {
    return "Today";
  } else if (DateFormat("dd").format(time) == DateFormat("dd").format(tomorrow)) {
    return "Tomorrow";
  } else {
    return "Select Date";
  }
}
