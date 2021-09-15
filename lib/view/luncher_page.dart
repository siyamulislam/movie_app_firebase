import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_hub/auth/auth_service.dart';
import 'package:movie_hub/view/homepage.dart';
import 'package:movie_hub/view/login.dart';

class LuncherPage extends StatefulWidget {
  const LuncherPage({Key? key}) : super(key: key);

  @override
  _LuncherPageState createState() => _LuncherPageState();
}

class _LuncherPageState extends State<LuncherPage> {
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      AuthService.getCurrentUser() == null
          ? Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Login()))
          : Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
    });

    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
