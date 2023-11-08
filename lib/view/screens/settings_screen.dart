// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:basics_firebase/view/home_screen/home_screen.dart';
// import 'package:basics_firebase/core/controller/login_sign_up_controller.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:basics_firebase/widgets/settings_tile.dart';
// import '';
// import '../../core/constant/app_route.dart';
// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }
//
// class _SettingsScreenState extends State<SettingsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Settings",
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//
//         ),),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 40),
//               SettingsTile(
//                 color: Colors.blue,
//                 icon: Ionicons.person_circle_outline,
//                 title: "Account",
//                 onTap: () {},
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               SettingsTile(
//                 color: Colors.green,
//                 icon: Ionicons.pencil_outline,
//                 title: "Edit Information",
//                 onTap: () {},
//               ),
//               const SizedBox(
//                 height: 40,
//               ),
//               SettingsTile(
//                 color: Colors.black,
//                 icon: Ionicons.moon_outline,
//                 title: "Theme",
//                 onTap: () {},
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               SettingsTile(
//                 color: Colors.purple,
//                 icon: Ionicons.language_outline,
//                 title: "Language",
//                 onTap: () {},
//               ),
//               const SizedBox(
//                 height: 40,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late PermissionStatus _cameraStatus;
  late PermissionStatus _locationStatus;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    final cameraStatus = await Permission.camera.status;
    final locationStatus = await Permission.location.status;

    setState(() {
      _cameraStatus = cameraStatus;
      _locationStatus = locationStatus;
    });
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();

    setState(() {
      _cameraStatus = status;
    });
  }

  Future<void> _requestLocationPermission() async {
    final status = await Permission.location.request();

    setState(() {
      _locationStatus = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Settings"),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text("Camera Permission"),
            trailing: Text(_cameraStatus.toString()),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  _requestCameraPermission();
                },
                child: Text("Request Camera Permission"),
              ),
            ],
          ),
          ListTile(
            title: Text("Location Permission"),
            trailing: Text(_locationStatus.toString()),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  _requestLocationPermission();
                },
                child: Text("Request Location Permission"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
