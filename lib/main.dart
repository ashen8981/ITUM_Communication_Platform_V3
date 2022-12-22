import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:itum_communication_platform/helper/helper_function.dart';
import 'package:itum_communication_platform/pages/auth/Login_Page.dart';
import 'package:itum_communication_platform/pages/groups/groups_home_page.dart';
import 'package:itum_communication_platform/pages/polls/polls_home_page.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus()async{
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if(value!=null){
        setState(() {
          _isSignedIn= value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (context) => DbProvider()),
      ],
      child:MaterialApp(
        debugShowCheckedModeBanner: false,
        home: _isSignedIn ? GroupHome() : LoginPage(),
      ),
    );
  }
}


