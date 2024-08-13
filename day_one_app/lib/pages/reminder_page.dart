import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({super.key});

  @override
  ReminderPageState createState() => ReminderPageState();
}

class ReminderPageState extends State<ReminderPage> {
  DateTime? _selectedDate;

  // Function to show the date picker dialog
  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    // Update the selected date
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _setReminder() async {
    if (_selectedDate != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // Save the selected date as a string in the format "yyyy-MM-dd"
      await prefs.setString('selectedDate', _selectedDate!.toIso8601String());
      Navigator.pop(context); // Just close the screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Reminder'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Date selection field

            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: 300,
                  child: TextField(
                    readOnly: true,
                    onTap: _pickDate,
                    decoration: InputDecoration(
                      labelText: 'Select Date',
                      hintText: _selectedDate != null
                          ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                          : 'Choose a date',
                      suffixIcon: const Icon(Icons.calendar_today),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Set reminder button
            ElevatedButton(
              onPressed: _selectedDate != null ? _setReminder : null,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white), // Set reminder and go back
              child: const Text('Set Reminder'),
            ),
          ],
        ),
      ),
    );
  }
}
