import 'package:flutter/material.dart';

import '../../../core/enums/time_slots.dart';

class TimeSlotSelection extends StatelessWidget {
  final String? morningTimeslot;
  final String? afternoonTimeslot;
  final Function(String?)? onMorningTimeslotChanged;
  final Function(String?)? onAfternoonTimeslotChanged;

  const TimeSlotSelection({
    super.key,
    required this.morningTimeslot,
    required this.afternoonTimeslot,
    this.onMorningTimeslotChanged,
    this.onAfternoonTimeslotChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Morning Time Slots
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Morning",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(1, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: morningTimeslot,
                    hint: const Text("Select Time"),
                    isDense: true,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 16.0,
                    ),
                    onChanged: onMorningTimeslotChanged,
                    items: MorningSlots.slots.map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey.shade900.withOpacity(0.75),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16.0),

        /// Afternoon Time Slots
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Afternoon",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(1, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: afternoonTimeslot,
                    hint: const Text("Select Time"),
                    isDense: true,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 16.0,
                    ),
                    onChanged: onAfternoonTimeslotChanged,
                    items: AfternoonSlots.slots.map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey.shade900.withOpacity(0.75),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
