import 'package:flutter/material.dart';
import 'package:flutter_interview_task/core/extensions/padding_extension.dart';
import 'package:flutter_interview_task/core/extensions/space_extension.dart';
import 'package:flutter_interview_task/ui/widgets/collection_delivery/date_radio_button.dart';
import 'package:flutter_interview_task/ui/widgets/collection_delivery/time_slot_selection.dart';
import 'package:intl/intl.dart';

class CollectionDeliveryScreen extends StatefulWidget {
  const CollectionDeliveryScreen({super.key});

  @override
  State<CollectionDeliveryScreen> createState() => _CollectionDeliveryScreenState();
}

class _CollectionDeliveryScreenState extends State<CollectionDeliveryScreen> {
  DateTime now = DateTime.now();
  DateTime? collectionDate;
  String? collectionMorningTimeSlot;
  String? collectionAfternoonTimeSlot;
  DateTime? deliveryDate;
  String? deliveryMorningTimeSlot;
  String? deliveryAfternoonTimeSlot;

  @override
  void initState() {
    collectionDate = now;
    deliveryDate = now;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text("Collection and Delivery"),
        backgroundColor: const Color(0xFFF5F5F5),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Collection Date & Time",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                /// Today
                Expanded(
                  child: DateRadioButton(
                    value: collectionDate!,
                    groupValue: now,
                    onChanged: (value) {
                      setState(() {
                        collectionDate = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16.0),

                /// Tomorrow
                Expanded(
                  child: DateRadioButton(
                    value: collectionDate!,
                    groupValue: now.add(const Duration(days: 1)),
                    onChanged: (value) {
                      setState(() {
                        collectionDate = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16.0),

                /// Day After tomorrow
                Expanded(
                  child: DateRadioButton(
                    value: collectionDate!,
                    groupValue: now.add(const Duration(days: 2)),
                    onChanged: (value) {
                      setState(() {
                        collectionDate = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            TimeSlotSelection(
              morningTimeslot: collectionMorningTimeSlot,
              afternoonTimeslot: collectionAfternoonTimeSlot,
              onMorningTimeslotChanged: (value) {
                setState(() {
                  collectionAfternoonTimeSlot = null;
                  collectionMorningTimeSlot = value;
                });
              },
              onAfternoonTimeslotChanged: (value) {
                setState(() {
                  collectionMorningTimeSlot = null;
                  collectionAfternoonTimeSlot = value;
                });
              },
            ),
            const SizedBox(height: 32.0),
            const Text(
              "Select Delivery Date & Time",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                /// Today
                Expanded(
                  child: DateRadioButton(
                    value: deliveryDate!,
                    groupValue: now,
                    onChanged: (value) {
                      setState(() {
                        deliveryDate = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16.0),

                /// Tomorrow
                Expanded(
                  child: DateRadioButton(
                    value: deliveryDate!,
                    groupValue: now.add(const Duration(days: 1)),
                    onChanged: (value) {
                      setState(() {
                        deliveryDate = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16.0),

                /// Day After tomorrow
                Expanded(
                  child: DateRadioButton(
                    value: deliveryDate!,
                    groupValue: now.add(const Duration(days: 2)),
                    onChanged: (value) {
                      setState(() {
                        deliveryDate = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            TimeSlotSelection(
              morningTimeslot: deliveryMorningTimeSlot,
              afternoonTimeslot: deliveryAfternoonTimeSlot,
              onMorningTimeslotChanged: (value) {
                setState(() {
                  deliveryAfternoonTimeSlot = null;
                  deliveryMorningTimeSlot = value;
                });
              },
              onAfternoonTimeslotChanged: (value) {
                setState(() {
                  deliveryMorningTimeSlot = null;
                  deliveryAfternoonTimeSlot = value;
                });
              },
            ),
            const SizedBox(height: 32.0),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Note: ",
                      style: TextStyle(
                        color: Colors.grey.shade900,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: "A delivery charge of £3.00 will be incurred for a full service.",
                      style: TextStyle(
                        color: Colors.grey.shade900,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                if (!collectionDate!.isBefore(deliveryDate!)) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          surfaceTintColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.error_outline_outlined,
                                color: Colors.red,
                                size: 40.0,
                              ).bottomSpacing(8.0),
                              Text(
                                "Error",
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                              ).bottomSpacing(8.0),
                              Text(
                                "Delivery Date should be after collection date",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ).bottomSpacing(16.0),
                              ElevatedButton(
                                onPressed: () => Navigator.of(context).pop(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text("Close"),
                              ),
                            ],
                          ).paddingAll(16.0),
                        );
                      });
                } else {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          surfaceTintColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Preview",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                              ).bottomSpacing(8.0),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Collection",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(fontWeight: FontWeight.bold),
                                    ).bottomSpacing(8.0),
                                    Text(
                                      "Date: ${DateFormat("dd-MM-yyyy").format(collectionDate!)}",
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    ).bottomSpacing(8.0),
                                    Visibility(
                                      visible: collectionMorningTimeSlot != null,
                                      child: Text(
                                        "Timeslot: $collectionMorningTimeSlot",
                                        style: Theme.of(context).textTheme.bodyLarge,
                                      ).bottomSpacing(8.0),
                                    ),
                                    Visibility(
                                      visible: collectionAfternoonTimeSlot != null,
                                      child: Text(
                                        "Timeslot: $collectionAfternoonTimeSlot",
                                        style: Theme.of(context).textTheme.bodyLarge,
                                      ).bottomSpacing(8.0),
                                    ),
                                  ],
                                ),
                              ).bottomSpacing(8.0),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Delivery",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(fontWeight: FontWeight.bold),
                                    ).bottomSpacing(8.0),
                                    Text(
                                      "Date: ${DateFormat("dd-MM-yyyy").format(deliveryDate!)}",
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    ).bottomSpacing(8.0),
                                    Visibility(
                                      visible: deliveryMorningTimeSlot != null,
                                      child: Text(
                                        "Timeslot: $deliveryMorningTimeSlot",
                                        style: Theme.of(context).textTheme.bodyLarge,
                                      ).bottomSpacing(8.0),
                                    ),
                                    Visibility(
                                      visible: deliveryAfternoonTimeSlot != null,
                                      child: Text(
                                        "Timeslot: $deliveryAfternoonTimeSlot",
                                        style: Theme.of(context).textTheme.bodyLarge,
                                      ).bottomSpacing(8.0),
                                    ),
                                  ],
                                ),
                              ).bottomSpacing(8.0),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      style: ElevatedButton.styleFrom(
                                        surfaceTintColor: Colors.white,
                                        foregroundColor: Colors.blue,
                                      ),
                                      child: const Text("Close"),
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        foregroundColor: Colors.white,
                                      ),
                                      child: const Text("Continue"),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ).paddingAll(16.0),
                        );
                      });
                }
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade700, Colors.blue.shade900],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(40.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(2, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
