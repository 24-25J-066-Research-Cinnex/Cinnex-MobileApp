import 'dart:io';
import 'package:cinnex_mobile/Disease%20Detection/Services/disease_service.dart';
import 'package:cinnex_mobile/Shared/Widget/camera_button.dart';
import 'package:flutter/material.dart';
import 'package:cinnex_mobile/Shared/Widget/custom_button.dart';
import 'package:logger/logger.dart';
import '../../Shared/Widget/curved_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import 'disease_detection_response.dart';

class DiseaseDetectionScreen extends StatefulWidget {
  const DiseaseDetectionScreen({super.key});
  @override
  DiseaseDetectionScreenState createState() => DiseaseDetectionScreenState();
}

class DiseaseDetectionScreenState extends State<DiseaseDetectionScreen> {
  File? _image; // Holds the selected image
  static final Logger _logger = Logger();
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  //function to call the disease detection service
  Future<Map<String, dynamic>> detectDisease() async {
    if (_image != null) {
      // Add logic to detect disease
      try {
        final detect = await DiseaseService.getDisease(_image!);
        _logger.d('API Response: $detect');
        return detect;
      } catch (e) {
        _logger.e('Error detecting disease: $e');
        rethrow;
      }
    } else {
      _logger.e('Please select all required fields');
      throw Exception('Please select all required fields');
    }
  }

  // Function to pick an image from the gallery
  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Function to capture an image using the camera
  Future<void> _captureImageWithCamera() async {
    final XFile? capturedFile =
        await _picker.pickImage(source: ImageSource.camera);
    if (capturedFile != null) {
      setState(() {
        _image = File(capturedFile.path);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme; // Access colors
    final textTheme = theme.textTheme; // Access text styles

    return Scaffold(
      body: Stack(
        children: [
          // Curved AppBar Background
          CurvedAppBar(
            title: AppLocalizations.of(context)!.cinnamon_diseases,
            trailingIcon: Icons.notifications,
            onTrailingIconPressed: null, // Add action if needed
          ),
          SafeArea(
            child: Column(
              children: [
                // AppBar
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40), // Space below AppBar

                // Instruction Text
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    AppLocalizations.of(context)!.cinnamon_diseases_content,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 10), // Space before input fields

                // Input Fields
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        GestureDetector(
                          onTap: () {
                            // Add file picker logic here
                            _pickImageFromGallery();// Open gallery to pick an image

                          },
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: colorScheme.primary, width: 2),
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey[100],
                            ),
                            child: _image != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.file(
                                      _image!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.image,
                                          size: 50, color: colorScheme.primary),
                                      const SizedBox(height: 8),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .cinnamon_diseases_button0,
                                        style: theme.textTheme.bodyMedium!
                                            .copyWith(
                                          color: colorScheme.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          AppLocalizations.of(context)!.cinnamon_diseases_or,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 10),
                        CameraButton(
                          text: AppLocalizations.of(context)!
                              .cinnamon_diseases_button1,
                          onPressed: () {
                            _captureImageWithCamera(); // Open camera to capture an image

                            },
                        ),
                        // Cinnamon Grade Dropdown

                        const SizedBox(height: 20),

                        // Region Dropdown

                        const SizedBox(height: 30),

                        // Predict Market Price Button
                        CustomButton(
                          text: AppLocalizations.of(context)!
                              .cinnamon_diseases_button2,
                          onPressed: () async {
                            // Add logic to detect disease
                            if (_image == null) {
                              // Add logic to detect disease
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: colorScheme.primary,
                                  
                                  content: Text(
                                    AppLocalizations.of(context)!
                                        .cinnamon_diseases_snack_bar,
                                    style: textTheme.labelSmall,
                                  ),
                                ),
                              );
                            } else {
                              try {
                                // Show loading dialog
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CircularProgressIndicator(),
                                            SizedBox(width: 16),
                                            Text(AppLocalizations.of(context)!.disease_ditect_loading,
                                              style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                                // Wait for a fixed duration (e.g., 3 seconds)
                                await Future.delayed(Duration(seconds: 4));
                                final detectResponse = await detectDisease();
                                // Close the loading dialog
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DiseaseDetectionResponseScreen(
                                            detect: detectResponse,
                                            image: _image!,
                                          )),
                                );
                              } catch (e) {
                                // Close the loading dialog
                                Navigator.pop(context);
                                _logger.e('Error getting forecast: $e');
                              }
                            }
                          },
                        ),
                        const Spacer(), // Push the button to the bottom
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
