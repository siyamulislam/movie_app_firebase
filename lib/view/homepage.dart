import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_hub/auth/auth_service.dart';
import 'package:movie_hub/db/firebase_db.dart';
import 'package:movie_hub/model/movie_model.dart';
import 'package:movie_hub/view/luncher_page.dart';
import 'package:movie_hub/widgets/movie_item.dart';

import 'add_movie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  reloadHome() {
    setState(() {});
  }

  bool isLoding = false;
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    WidgetsBinding.instance!.addPostFrameCallback((_) {

      if (!AuthService.isVerified()) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('OPS!..\n Till now you are un Verified!',style: TextStyle(color: Colors.blue),),
          content: new Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
           Text('Click Send and Check your MailBox.'),
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
                ElevatedButton(
                  onPressed: () {
                    AuthService.sendVerificationMail();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Send'),
                ),
              ],
            ),
          ],
        ),
      );
    }


    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Movie Hub'),
            Text(
              AuthService.isVerified() ? "verified" : "Unveriied",
            ),
          ],
        ),
        actions: [
          PopupMenuButton(
              onSelected: (value) async {
                if (value == 4) {
                  setState(() {
                    isLoding = true;
                  });
                  await AuthService.signOut().then((value) =>
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LuncherPage())));
                  setState(() {
                    isLoding = false;
                  });
                }
              },
              itemBuilder: (context) => [
                    PopupMenuItem(value: 0, child: Text('About')),
                    PopupMenuItem(value: 1, child: Text('Profile')),
                    PopupMenuItem(value: 2, child: Text('Rate Us')),
                    PopupMenuItem(value: 3, child: Text('Settings')),
                    PopupMenuItem(value: 4, child: Text('Sign Out')),
                  ]),
        ],
      ),
      body: isLoding
          ? Center(
              child: CircularProgressIndicator(),
            )
          : FutureBuilder(
              future: DBFirebaseHelper.getAllMovie(),
              builder: (context, AsyncSnapshot<List<Movies>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.length == 0) {
                    return Center(child: Text("No data found!"));
                  }
                  return ListView.builder(
                      itemBuilder: (context, ee) => MovieItem(
                            e: snapshot.data![ee],
                            refresh: () => reloadHome(),
                          ),
                      itemCount: snapshot.data!.length);
                }
                if (snapshot.hasError) {
                  print(snapshot.error.toString());
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Add_Movie()))
              .then((value) {
            if (value == true) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Movie Added!"),
                duration: Duration(seconds: 4),
                action: SnackBarAction(label: 'Undo', onPressed: () {}),
              ));
            }
            setState(() {});
          });
        },
        tooltip: "add",
        child: Icon(Icons.add, size: 35),
      ),
      backgroundColor: Colors.grey.shade200,
    );
  }
}
