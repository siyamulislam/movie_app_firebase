import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_hub/model/movie_model.dart';

final String collectionPath = "Movies";

class DBFirebaseHelper {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  //* insert  Movies
  static Future<void> insertMovie(Movies movie) async {
    DocumentReference doc = db.collection(collectionPath).doc();
    movie.docId = doc.id;
    return doc.set(movie.toMap());
  }

  //* get all movies
  static Future<List<Movies>> getAllMovie() async {
    List<Movies> movies = [];
    QuerySnapshot querySnapshot = await db.collection(collectionPath).get();
    //movies= querySnapshot.docs.map((item) => Movies.fromMap(item.data())).toList();
    movies = querySnapshot.docs
        .map((item) => Movies.fromMap(item.data() as Map<String, dynamic>))
        .toList();
    return movies;
  }

  //* get  movie by ID
  static Future<Movies> getMovieByID(String? mID) async {
    final snapshot = await db.collection(collectionPath).doc(mID).get();
    return Movies.fromMap(snapshot.data() as Map<String, dynamic>);
  }

  //* delete  movie by ID
  static Future<void> deleteMovieByID(String? docID) async {
    return db.collection(collectionPath).doc(docID).delete();
  }

  static updateMovieFav(String? docID, bool isFavv) async {
    int isFavDegit;
    if (isFavv == true)
      isFavDegit = 0;
    else
      isFavDegit = 1;
    final doc = db.collection(collectionPath).doc(docID);
    return doc.update({
      'movie_isfav': isFavDegit,
    });
  }

  static updateMovieRating(String? docID, double? _rating) async {
    final doc = db.collection(collectionPath).doc(docID);
    return doc.update({
      '$MOVIE_COL_RATING': _rating,
    });
  }

  static updateMovieName(String? docID, String? _name) async {
    final doc = db.collection(collectionPath).doc(docID);
    return doc.update({'$MOVIE_COL_NAME': _name,});
  }
}
