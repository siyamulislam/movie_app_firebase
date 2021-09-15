
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_hub/db/firebase_db.dart';
import 'package:movie_hub/model/movie_model.dart';
import 'movie_details.dart';

// ignore: must_be_immutable
class MovieItem extends StatefulWidget {
  // const MovieItem({ Key? key }) : super(key: key);
  final Movies? e;
  int isfavv = 0;
  final VoidCallback? refresh;
  MovieItem({required this.e, this.refresh});

  @override
  _MovieItemState createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(25),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          Icons.delete_forever,
          size: 80,
          color: Colors.red,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        DBFirebaseHelper.deleteMovieByID(widget.e!.docId).then((value) {
          widget.refresh!();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Movie Deleted"),
          
            action: SnackBarAction(label: 'OK', onPressed: () {}),
          ));
        });
      },
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Row(
                children: [
                  Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                    size: 40,
                  ),
                  Text(
                    "Delete ${widget.e!.name}!",
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
              content: Text("Are you sre to delete this item?"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text("CANCEL")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text("CONFIRM"))
              ],
              elevation: 5,
            );
          },
        );
      },
      child: InkWell(
        onTap: () {
          // ignore: unnecessary_statements
          null;
          Navigator.push(
              context,
              //MaterialPageRoute(builder: (context) => MovieDetails(widget.e.id)));
              MaterialPageRoute(
                  builder: (context) => MovieDetails(widget.e!.docId))).then(
              (value) {
            widget.refresh!();
          });
        },
        child: Card(
          shadowColor: Colors.blue,
          color: Colors.blueGrey.shade100,
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    child: Hero(
                      tag: widget.e!.docId ?? '',
                      child: 
                      // widget.e!.imageURL ==null?  Center(child: CircularProgressIndicator(color: Colors.white,),)
                      // :
                      // Image.network(widget.e!.imageURL ?? '',
                      //     height: 150,
                      //     width: double.infinity,
                      //     fit: BoxFit.cover),

                      FadeInImage.assetNetwork(
                        fadeInDuration: Duration(seconds: 1),
                        //fadeOutDuration: Duration(seconds: 1),
                        fadeInCurve: Curves.bounceIn,
                        //fadeOutCurve: Curves.bounceInOut,
                        height: 150,
                           width: double.infinity,
                           fit: BoxFit.cover,
                        placeholder: 'assets/images/ph.png',
                         image: widget.e!.imageURL ?? ''),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.black.withOpacity(0.35),
                      ),
                      child: FittedBox(
                        child: Text(
                          'UID: ' + widget.e!.docId.toString() + '',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Text('Name: ' + widget.e.name),
                          Text(
                            widget.e!.name ?? 'no name',
                            style: Theme.of(context).textTheme.headline6,
                          ),

                          Row(
                            children: [
                              Icon(Icons.category,
                                  color: Colors.green, size: 12),
                              SizedBox(width: 5),
                              Text(widget.e!.category ?? 'no category',
                                  style: Theme.of(context).textTheme.bodyText2),
                            ],
                          )
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //Text('Name: ' + widget.e.name),
                            Icon(Icons.star, color: Colors.red, size: 18),
                            SizedBox(width: 5),
                            Text(widget.e!.rating.toString(),
                                style: Theme.of(context).textTheme.bodyText2),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //Text('Name: ' + widget.e.name),
                            Icon(Icons.date_range,
                                color: Colors.blue, size: 18),
                            SizedBox(width: 5),
                            Text(
                                DateFormat('MM, yyyy').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        widget.e!.releaseDate ?? 0000)),
                                style: Theme.of(context).textTheme.bodyText2),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //Text('Name: ' + widget.e.name),

                        SizedBox(width: 15),
                        GestureDetector(
                          child: Icon(
                              widget.e!.isfav
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                              color: Colors.red,
                              size: 30),
                          onTap: () {
                            _changeFav();
                            if (widget.e!.isfav) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Add to favorite!"),
                                duration: Duration(seconds: 7),
                                action: SnackBarAction(
                                    label: 'Undo',
                                    onPressed: () => _changeFav()),
                              ));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Remove to Favorite!"),
                                duration: Duration(seconds: 7),
                                action: SnackBarAction(
                                    label: 'Undo',
                                    onPressed: () => _changeFav()),
                              ));
                            }
                          },
                        ),

                        SizedBox(width: 5),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _changeFav() {
    setState(() {
      DBFirebaseHelper.updateMovieFav(widget.e!.docId, widget.e!.isfav);
      widget.e!.isfav = !widget.e!.isfav;
    });
  }
}
