import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_hub/db/firebase_db.dart';
import 'package:movie_hub/db/temp_db.dart';
import 'package:movie_hub/model/movie_model.dart';

// ignore: must_be_immutable
class MovieDetails extends StatefulWidget {
  String? docId;

  MovieDetails(this.docId);

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
 // bool isLoading= false;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        //   await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
        return true;
      },
      child: Scaffold(
        body: FutureBuilder(
          future: DBFirebaseHelper.getMovieByID(widget.docId),
          builder: (context, AsyncSnapshot<Movies> snapshot) {
            // print(snapshot.data.id);
               
               //  isLoading=false;
              
            if (snapshot.hasData) {
            
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    stretch: true,
                    // floating: true,
                    expandedHeight: 300,
                    flexibleSpace: FlexibleSpaceBar(
                        background: Hero(
                            tag: snapshot.data!.docId ?? 0,
                           // child: Image.file(File(snapshot.data!.image ?? ''),
                            child:
                            // isLoading?  
                            // Center(child: CircularProgressIndicator(color: Colors.white,),)
                            //     :
                            
                            Image.network(snapshot.data!.imageURL ?? '',
                                fit: BoxFit.cover)),
                        title: Text(snapshot.data!.name ?? 'no name')),


                    // background: Image.asset(widget.e.image,
                    //     height: 150, width: double.infinity, fit: BoxFit.cover),
                    //   bac
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                snapshot.data!.name ?? 'no name',
                                style: TextStyle(
                                    fontFamily: 'ZenTokyoZoo', fontSize: 35),
                              ),
                              IconButton(
                                  onPressed: () {
                                    var controllerTitle =
                                        TextEditingController();
                                    controllerTitle.text =
                                        snapshot.data!.name ?? 'no name';
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text('Update Name'),
                                        content: new Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            TextField(
                                              controller: controllerTitle,
                                            ),
                                          ],
                                        ),
                                        actions: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Close'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    DBFirebaseHelper
                                                        .updateMovieName(
                                                            widget.docId,
                                                            controllerTitle
                                                                .text);
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Save'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.edit_outlined))
                            ],
                          ),
                          Text(
                            snapshot.data!.category ?? 'no category',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "Rating: " + snapshot.data!.rating.toString(),
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 20),
                          ),
                          RatingBar.builder(
                            initialRating: snapshot.data!.rating ?? 0.0,
                            minRating: 0,
                            itemSize: 28,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            //glow: false,
                            itemCount: 10,
                            itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                               DBFirebaseHelper.updateMovieRating(
                                   widget.docId, rating);
                               setState(() {});
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            snapshot.data!.description ?? '',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            description,
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            description,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                fontFamily: 'Quantico',
                                fontSize: 14),
                          ),
                          Text(
                            description,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.italic,
                                fontFamily: 'ZenTokyoZoo',
                                fontSize: 25),
                          ),
                        ],
                      ),
                    )
                  ])),
                ],
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("Failed to Fetch data!"),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
  // Future _onWillPop() async{
  //   return Navigator.of(context).pop(true);
  // }
}
