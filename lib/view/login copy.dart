import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:movie_hub/auth/auth_service.dart';
import 'package:movie_hub/view/homepage.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _loginFormKey = GlobalKey<FormState>();
  static String? name, email, password;
  String? uid;
  bool isLog = true, _slowAnimations = false, _isLogin = true;
  String imgPath = 'assets/images/2.png';
  TextStyle ts1 =
      TextStyle(fontSize: 30, color: Colors.blue, fontWeight: FontWeight.bold);
  TextStyle ts2 =
      TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);
  TextStyle ts3 = TextStyle(
      fontSize: 14, color: Colors.black54, fontWeight: FontWeight.normal);

  @override
  Widget build(BuildContext context) {
    _authenticate() async {
      try {
        if (_isLogin && email != null && password != null) {
          //*login
          uid = await AuthService.login(email!, password!);
        } else {
          //*register
          uid = await AuthService.registration(email!, password!);
        }

        if (uid != null) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Something Wrong!: " + e.toString()),
          duration: Duration(seconds: 4),
          action: SnackBarAction(label: 'ok', onPressed: () {}),
        ));
      }
    }

    TextStyle ts4 = TextStyle(
        fontSize: 14, color: Colors.blue, fontWeight: FontWeight.bold);
    var centerImage = Center(
        child: Image.asset(imgPath,
            width: MediaQuery.of(context).size.width / 2, fit: BoxFit.contain));
    var cardLogin = Card(
        elevation: 11,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        //shape: ,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: _loginFormKey,
            child: Column(
              children: [
                Text("Login", style: ts1, textAlign: TextAlign.center),
                //Text(password ?? 'No pass',textAlign: TextAlign.center),
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'someone@gmail.com',
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return ("Enter valid Email!");
                    }
                    return null;
                  },
                onSaved: (newValue) {
                    if(newValue!=null){
                        email = newValue;
                    }
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Password'),
                  validator: (value) {
                    if (value?.isEmpty ?? true)
                      return ("Enter valid Password!");
                  },
                  onSaved: (newValue) {
                    if(newValue!=null){
                        password = newValue;
                    }
                  },
                ),
                Container(
                    padding: EdgeInsets.all(4),
                    width: double.infinity,
                    child: GestureDetector(
                      child: Text('Forget Password?',
                          style: ts3, textAlign: TextAlign.right),
                      onTap: () {
                        print('object');
                      },
                    )),
                SizedBox(height: 6),
                ElevatedButton(
                    onPressed: () {
                      _isLogin = true;
                      _authenticate();
                      _saveData();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Login ', style: ts2),
                        Icon(Icons.login),
                      ],
                    )),
                SizedBox(
                  height: 8,
                ),
                Text.rich(TextSpan(style: ts3, children: [
                  TextSpan(text: 'Now user? '),
                  TextSpan(
                      text: 'Registration ',
                      style: ts4,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          setState(() {
                            isLog = false;
                          });
                        }),
                  TextSpan(text: 'Now!')
                ])),
              ],
            ),
          ),
        ));
    var cardRegistration = Card(
        elevation: 11,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        //shape: ,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: _loginFormKey,
            child: Column(
              children: [
                Text("Registration", style: ts1, textAlign: TextAlign.center),
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Mr. someone',
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Enter your Name");
                    }
                  },
                  onSaved: (newValue) {
                    if (newValue != null) name = newValue;
                  },
                ),
                SizedBox(height: 8),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'someone@gmail.com',
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Enter valid Email!");
                    }
                  },
                  onSaved: (newValue) {
                    if (newValue != null) email = newValue;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Password'),
                  validator: (value) {
                    if (value!.isEmpty) return ("Enter valid Password!");
                  },
                  onSaved: (newValue) {
                    if (newValue != null) password = newValue;
                  },
                ),
                Container(
                    padding: EdgeInsets.all(4),
                    width: double.infinity,
                    child: GestureDetector(
                      child: Text('Save Password',
                          style: ts3, textAlign: TextAlign.right),
                      onTap: () {
                        print('Save Password');
                      },
                    )),
                SizedBox(height: 6),
                ElevatedButton(
                    onPressed: () {
                      _isLogin = false;
                        _authenticate();
                      // _saveData();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Registration ', style: ts2),
                        Icon(Icons.app_registration),
                      ],
                    )),
                SizedBox(height: 8),
                Text.rich(TextSpan(style: ts3, children: [
                  TextSpan(text: 'Already have an account? '),
                  TextSpan(
                      text: 'Login ',
                      style: ts4,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          setState(() {
                            isLog = true;
                          });
                        }),
                  TextSpan(text: 'Now!')
                ])),
              ],
            ),
          ),
        ));
    var safeArea = SafeArea(
      child: SwitchListTile(
        value: _slowAnimations,
        onChanged: (bool value) async {
          setState(() {
            _slowAnimations = value;
          });
          if (_slowAnimations) {
            await Future<void>.delayed(const Duration(milliseconds: 300));
          }
          timeDilation = _slowAnimations ? 20.0 : 1.0;
        },
        title: const Text('Slow animations'),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(isLog ? 'Login' : 'Registration'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(left: 20, right: 20, top: 5),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            //centerImage,
            Expanded(
              child: ListView(
                children: [
                  centerImage,
                  //Log ? centerImage : FlutterLogo(size:  MediaQuery.of(context).size.width / 5),
                  isLog ? cardLogin : cardRegistration,
                ],
              ),
            ),
            const Divider(height: 0.0),
            safeArea,
          ],
        ),
      ),
    );
  }

  _saveData() {
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();
    }
  }
}
