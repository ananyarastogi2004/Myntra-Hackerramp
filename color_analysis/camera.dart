import 'dart:io';
import 'package:myntra/screens/analysis_screen.dart';
import 'package:myntra/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as img; // Import the image package
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

// Create a FaceDetector instance
final options = FaceDetectorOptions(); // You can customize options if needed
final faceDetector = FaceDetector(options: options);

class Camera extends StatefulWidget {
  const Camera({super.key});
  @override
  State<Camera> createState() {
    return _Camera();
  }
}

class _Camera extends State<Camera> {
  CameraController? _controller;
  XFile? _image;
  late List<CameraDescription> cameras;
  bool isUsingFrontCamera = false;
  String? foreheadHex, leftCheekHex, rightCheekHex, chinHex, jawlineHex;
  File? _selectedImageFile;


  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> _setupCamera(CameraDescription camera) async {
    // Dispose the previous controller
    _controller?.dispose();
    // Setup the new controller
    _controller = CameraController(camera, ResolutionPreset.high);
    // Wait for camera controller to initialize
    await _controller!.initialize();
    // Set state for preview UI rebuilding
    setState(() {

    });
  }

  Future<void> initializeCamera() async {
    // Obtain a list of available cameras on the device.
    cameras = await availableCameras();
    // Get the first camera from the list of available cameras.
    CameraDescription rearCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back);
    // Setup the camera
    _setupCamera(rearCamera);
  }

  void retake() async {
    await _controller!.initialize();
    setState(() {
      _image = null;
      foreheadHex = null;
      leftCheekHex = null;
      rightCheekHex = null;
      chinHex = null;
      jawlineHex = null;
    });
  }

  void switchCamera() async {
    if (cameras.isEmpty) {
      // No cameras found
      return;
    }
    // Switch between front and back cameras
    isUsingFrontCamera = !isUsingFrontCamera;
    CameraLensDirection lensDirection = isUsingFrontCamera
        ? CameraLensDirection.front
        : CameraLensDirection.back;
    CameraDescription selectedCamera =
        cameras.firstWhere((camera) => camera.lensDirection == lensDirection);
    await _setupCamera(selectedCamera);
  }

  @override
  void dispose() {
    _controller?.dispose();
    faceDetector.close();
    super.dispose();
  }

  void takePic() async {
    if (_controller != null && _controller!.value.isInitialized) {
      try {
        var pic = await _controller!.takePicture();
        File imageFile = File(pic.path);

        if (isUsingFrontCamera) {
          // Load the image
          var originalImage =
              img.decodeImage(await File(pic.path).readAsBytes());
          // Mirror the image horizontally
          var mirroredImage = img.flipHorizontal(originalImage!);
          // Save the mirrored image back to a file
          imageFile = File(pic.path)
            ..writeAsBytesSync(img.encodeJpg(mirroredImage));
        } else {
          imageFile = File(pic.path);
        }

        // Create an InputImage object from the image file
        final inputImage = InputImage.fromFile(imageFile);

        // Perform face analysis
        final faces = await faceDetector.processImage(inputImage);
        if (faces.isEmpty) {
          // No faces detected, display a Snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Error: No face detected in the image."),
              duration: Duration(seconds: 2),
            ),
          );
          return;
        } else {
          // If face is detected, perform the color extraction
          var face = faces.first;
          var foreheadColor =
              _getRegionColor(imageFile, face.boundingBox, 'forehead');
          var leftCheekColor =
              _getRegionColor(imageFile, face.boundingBox, 'leftCheek');
          var rightCheekColor =
              _getRegionColor(imageFile, face.boundingBox, 'rightCheek');
          var chinColor = _getRegionColor(imageFile, face.boundingBox, 'chin');
          var jawlineColor =
              _getRegionColor(imageFile, face.boundingBox, 'jawline');

          setState(() {
            _image = pic;
            _selectedImageFile = imageFile;
            foreheadHex = _colorToHex(foreheadColor);
            leftCheekHex = _colorToHex(leftCheekColor);
            rightCheekHex = _colorToHex(rightCheekColor);
            chinHex = _colorToHex(chinColor);
            jawlineHex = _colorToHex(jawlineColor);
          });
        }
      } catch (e) {
        print("Error capturing the image: $e");
      }
    }
  }


  Color _getRegionColor(File imageFile, Rect faceRect, String region) {
    var image = img.decodeImage(imageFile.readAsBytesSync());
    Rect regionRect;

    switch (region) {
      case 'forehead':
        regionRect = Rect.fromLTWH(
          faceRect.left + faceRect.width * 0.25,
          faceRect.top + faceRect.height * 0.15,
          faceRect.width * 0.5,
          faceRect.height * 0.1,
        );
        break;
      case 'leftCheek':
        regionRect = Rect.fromLTWH(
          faceRect.left + faceRect.width * 0.15,
          faceRect.top + faceRect.height * 0.4,
          faceRect.width * 0.2,
          faceRect.height * 0.2,
        );
        break;
      case 'rightCheek':
        regionRect = Rect.fromLTWH(
          faceRect.left + faceRect.width * 0.65,
          faceRect.top + faceRect.height * 0.4,
          faceRect.width * 0.2,
          faceRect.height * 0.2,
        );
        break;
      case 'chin':
        regionRect = Rect.fromLTWH(
          faceRect.left + faceRect.width * 0.4,
          faceRect.top + faceRect.height * 0.75,
          faceRect.width * 0.2,
          faceRect.height * 0.1,
        );
        break;
      case 'jawline':
        regionRect = Rect.fromLTWH(
          faceRect.left + faceRect.width * 0.3,
          faceRect.top + faceRect.height * 0.8,
          faceRect.width * 0.4,
          faceRect.height * 0.1,
        );
        break;
      default:
        regionRect = Rect.zero;
    }

    List<num> reds = [];
    List<num> greens = [];
    List<num> blues = [];

    for (int y = regionRect.top.toInt(); y < regionRect.bottom.toInt(); y++) {
      for (int x = regionRect.left.toInt(); x < regionRect.right.toInt(); x++) {
        final pixel = image?.getPixel(x, y);
        if (pixel != null) {
          reds.add(pixel.r);
          greens.add(pixel.g);
          blues.add(pixel.b);
        }
      }
    }

    int avgRed = reds.reduce((a, b) => a + b) ~/ reds.length;
    int avgGreen = greens.reduce((a, b) => a + b) ~/ greens.length;
    int avgBlue = blues.reduce((a, b) => a + b) ~/ blues.length;

    return Color.fromARGB(255, avgRed, avgGreen, avgBlue);
  }

  String _colorToHex(Color color) {
    return '#${color.red.toRadixString(16).padLeft(2, '0')}${color.green.toRadixString(16).padLeft(2, '0')}${color.blue.toRadixString(16).padLeft(2, '0')}';
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              if (_image != null) {
                retake();
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              }
            },
            icon: const Icon(Icons.arrow_back)),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          if (_image != null)
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.file(File(_image!.path)),
                ),
                if (_selectedImageFile != null && 
                    foreheadHex != null &&
                    leftCheekHex != null &&
                    rightCheekHex != null &&
                    chinHex != null &&
                    jawlineHex != null)
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Forehead: $foreheadHex'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Left Cheek: $leftCheekHex'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Right Cheek: $rightCheekHex'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Chin: $chinHex'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Jawline: $jawlineHex'),
                      ),
                      const SizedBox(height: 10,),
                      ElevatedButton(
                        onPressed: () {
                          if (_selectedImageFile != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SeasonalColorAnalysisScreen(imageFile: _selectedImageFile!)),
                            );
                          } else {
                          // Handle case where no image is selected yet
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please take a picture first.'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        }, 
                        child: const Text('View my Detailed Color Analysis'),
                      ),
                    ],
                  ),
              ],
            )
          else if (_controller != null && _controller!.value.isInitialized)
            SizedBox(
              height: 650,
              width: 100,
              child: isUsingFrontCamera
                  ? Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(0),
                      child: AspectRatio(
                        aspectRatio: _controller!.value.aspectRatio,
                        child: CameraPreview(_controller!),
                      ),
                    )
                  : AspectRatio(
                      aspectRatio: _controller!.value.aspectRatio,
                      child: CameraPreview(_controller!),
                    ),
            )
          else
            const Center(child: CircularProgressIndicator()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_image == null)
                FloatingActionButton(
                  onPressed: takePic,
                  child: const Icon(Icons.camera),
                )
              else
                FloatingActionButton(
                    onPressed: retake, child: const Icon(Icons.refresh)),
              const SizedBox(
                width: 40,
              ),
              
              if (_controller != null &&
                  _controller!.value.isInitialized &&
                  _image == null)
                FloatingActionButton(
                  onPressed: switchCamera,
                  child: const Icon(Icons.switch_camera),
                )
            ],
          ),
        ],
      ),
    );
  }
}
