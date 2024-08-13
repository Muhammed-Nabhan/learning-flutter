import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  List<CameraDescription>? cameras;
  int selectedCameraIndex = 0;
  bool isCameraReady = false;
  String? imagePath;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras!.isNotEmpty) {
        _controller = CameraController(
          cameras![selectedCameraIndex],
          ResolutionPreset.high,
        );
        _initializeControllerFuture = _controller.initialize();
        await _initializeControllerFuture;

        setState(() {
          isCameraReady = true; // Camera is ready for use
        });
      } else {
        print('No cameras available');
      }
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _switchCamera() {
    if (cameras == null || cameras!.isEmpty) {
      print('No cameras available');
      return;
    }

    selectedCameraIndex = (selectedCameraIndex + 1) % cameras!.length;

    setState(() {
      isCameraReady = false;
    });

    _controller.dispose();
    initializeCamera();
  }

  Future<void> _takePicture() async {
    if (!isCameraReady) {
      print('Camera is not ready');
      return;
    }

    try {
      // Ensure the camera is initialized
      await _initializeControllerFuture;

      // Take the picture and get the XFile
      final XFile image = await _controller.takePicture();

      // Get the directory to save the image
      final directory = await getApplicationDocumentsDirectory();
      final path =
          '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';

      // Save the image to the specified path
      await image.saveTo(path);

      // Save image path to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('imagePath', path);

      setState(() {
        imagePath = path; // Update the state to display the new image
      });

      // Optionally, show a Snackbar to notify the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Picture taken and saved.')),
      );
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: isCameraReady
          ? Column(
              children: [
                Expanded(
                  child: CameraPreview(_controller),
                ),
                if (imagePath != null) ...[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.file(File(imagePath!)),
                  ),
                ],
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _takePicture,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber[300],
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Take Picture'),
                      ),
                      ElevatedButton(
                        onPressed: _switchCamera,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber[300],
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Switch Camera'),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
