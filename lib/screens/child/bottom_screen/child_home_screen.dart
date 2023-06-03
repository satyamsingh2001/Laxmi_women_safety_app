import 'package:background_sms/background_sms.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laxmi/constants/constantcolor.dart';
import 'package:laxmi/db/db_services.dart';
import 'package:laxmi/models/contants_model.dart';
import 'package:laxmi/utils/Utils.dart';
import 'package:laxmi/widgets/home_widgets/custom_carousal.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shake/shake.dart';

import '../../../widgets/home_widgets/emergency/emergency.dart';
import '../../../widgets/home_widgets/livesafe/livesafe.dart';
import '../../../widgets/share_locations/share_loc.dart';

class Child_Home_Screen extends StatefulWidget {
  const Child_Home_Screen({Key? key}) : super(key: key);

  @override
  State<Child_Home_Screen> createState() => _Child_Home_ScreenState();
}

class _Child_Home_ScreenState extends State<Child_Home_Screen> {

  int qIndex = 0;
  Position? _curentPosition;
  String? _curentAddress;
  LocationPermission? permission;
  _getPermission() async => await [Permission.sms].request();
  _isPermissionGranted() async => await Permission.sms.status.isGranted;
  _sendSms(String phoneNumber, String message, {int? simSlot}) async {
    SmsStatus result = await BackgroundSms.sendMessage(
        phoneNumber: phoneNumber, message: message, simSlot: 1);
    if (result == SmsStatus.sent) {
      print("Sent");
      Utils.showToastMsg( "send");
    } else {
      Utils.showToastMsg("failed");
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  _getCurrentLocation() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _curentPosition = position;
        print(_curentPosition!.latitude);
        _getAddressFromLatLon();
      });
    }).catchError((e) {
      Utils.showToastMsg( e.toString());
    });
  }

  _getAddressFromLatLon() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _curentPosition!.latitude, _curentPosition!.longitude);

      Placemark place = placemarks[0];
      setState(() {
        _curentAddress =
        "${place.locality},${place.postalCode},${place.street},";
      });
    } catch (e) {
      Utils.showToastMsg( e.toString());
    }
  }



  getAndSendSms() async {
    List<Contact_Model> contactList = await DatabaseHelper().geContact_ModelList();

    String messageBody =
        "https://maps.google.com/?daddr=${_curentPosition!.latitude},${_curentPosition!.longitude}";
    if (await _isPermissionGranted()) {
      contactList.forEach((element) {
        _sendSms("${element.number}", "i am in trouble $messageBody");
      });
    } else {
      Utils.showToastMsg("something wrong");
    }
  }

  @override
  void initState() {
    super.initState();
    _getPermission();
    _getCurrentLocation();
    ////// shake feature ///
    ShakeDetector.autoStart(
      onPhoneShake: () {
        getAndSendSms();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Shake!'),
          ),
        );
        // Do stuff on phone shake
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );

    // To close: detector.stopListening();
    // ShakeDetector.waitForStart() waits for user to call detector.startListening();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Text("Laxmi"
                , style: GoogleFonts.lobster(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width*0.08,
                    color: ConstantColor.button
                ),
              ),
              SizedBox(height: 10,),
              CustomCarouel(),
              SizedBox(height: 10,),
              Text("Emergency"
                , style: TextStyle(
                    fontWeight: FontWeight.bold,
                    // fontSize: MediaQuery.of(context).size.width*0.06,
                    color: Colors.black
                ),
              ),
              SizedBox(height: 10,),
              Emergency(),
              SizedBox(height: 10,),
              Text("Explore Livesafe"
                , style: TextStyle(
                    fontWeight: FontWeight.bold,
                    // fontSize: MediaQuery.of(context).size.width*0.06,
                    color: Colors.black
                ),
              ),
              SizedBox(height: 10,),
              Livesafe(),
              SizedBox(height: 10,),
              ShareLocation(),
              Align(
                alignment: Alignment.bottomRight,
                child: Text("@ Proudly made by Kmcians"
                  , style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // fontSize: MediaQuery.of(context).size.width*0.06,
                      color: Colors.grey
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
