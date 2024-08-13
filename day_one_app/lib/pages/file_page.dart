import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FilePage extends StatefulWidget {
  const FilePage({super.key});

  @override
  State<FilePage> createState() => _FilePageState();
}

class _FilePageState extends State<FilePage> {
  String? _filePath;

  Future<void> _pickFile() async {
    // Open the file picker dialog
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      // If a file is selected, update the state with the file path
      setState(() {
        _filePath = result.files.single.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Picker'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _pickFile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber[300],
                foregroundColor: Colors.white,
              ),
              child: const Text('Open Files'),
            ),
            if (_filePath != null)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Selected file path:\n$_filePath',
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
