import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl for date formatting

class DateTimeSelectionWidget extends StatelessWidget {
  const DateTimeSelectionWidget({
    super.key,
    required this.selectedDate,
    required this.selectedTime,
    required this.onTap,
    required this.title,
    required this.showDate,
  });

  final DateTime? selectedDate;
  final TimeOfDay selectedTime;
  final VoidCallback onTap;
  final String title;
  final bool showDate;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var formatter = DateFormat('dd/MM/yyyy'); // Formatter for date display

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 5),
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                title,
                style: textTheme.headlineSmall,
              ),
            ),
            Row(
              children: [
                Visibility(
                  visible: showDate,
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 150,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        selectedDate == null
                            ? 'Data'
                            : formatter.format(
                                selectedDate!), // Display formatted date
                        style: textTheme.titleSmall,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: !showDate || selectedDate == null,
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 150,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        selectedTime.format(context), // Display formatted time
                        style: textTheme.titleSmall,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
