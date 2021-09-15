

 // ignore: non_constant_identifier_names
 String MOVIE_TABLE = 'movie_tbl';
// ignore: non_constant_identifier_names
final String MOVIE_COL_ID = 'movie_id';
// ignore: non_constant_identifier_names
final String MOVIE_COL_NAME = 'movie_name';
// ignore: non_constant_identifier_names
final String MOVIE_COL_CATEGORY = 'movie_category';
// ignore: non_constant_identifier_names
final String MOVIE_COL_RELEASEDATE = 'movie_releasedATE';
// ignore: non_constant_identifier_names
final String MOVIE_COL_RATING = 'movie_rating';
// ignore: non_constant_identifier_names
final String MOVIE_COL_IMAGE = 'movie_image';
final String MOVIE_COL_IMAGE_URL = 'movie_image_url';
// ignore: non_constant_identifier_names
final String MOVIE_COL_DES = 'movie_description';
// ignore: non_constant_identifier_names
final String MOVIE_COL_FAV = 'movie_isfav';
// ignore: non_constant_identifier_names
final String MOVIE_DOC_ID = 'doc_id';

class Movies {
  int? id;
  String? docId;
  String? name;
  String? category;
  int? releaseDate;
  double? rating;
  String? image;
  String? imageURL;
  String? description;
  bool isfav=false;

  Movies({
    this.id,
    this.docId,
    this.name,
    this.category,
    this.releaseDate,
    this.rating,
    this.image,
    this.imageURL,
    this.description,
    this.isfav = false,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      MOVIE_COL_NAME: name,
      MOVIE_DOC_ID: docId,
      MOVIE_COL_CATEGORY: category,
      MOVIE_COL_RELEASEDATE: releaseDate,
      MOVIE_COL_RATING: rating,
      MOVIE_COL_IMAGE: image,
      MOVIE_COL_IMAGE_URL: imageURL,
      MOVIE_COL_DES: description,
      MOVIE_COL_FAV: isfav ? 1 : 0
    };
    if (id != null) {
      map[MOVIE_COL_ID] = id;
    }
    return map;
  }

  Movies.fromMap(Map<String,dynamic> map){
    id=map[MOVIE_COL_ID];
    docId=map[MOVIE_DOC_ID];
    name=map[MOVIE_COL_NAME];
    category=map[MOVIE_COL_CATEGORY];
    releaseDate=map[MOVIE_COL_RELEASEDATE];
    rating=map[MOVIE_COL_RATING];
    image=map[MOVIE_COL_IMAGE];
    imageURL=map[MOVIE_COL_IMAGE_URL];
    description=map[MOVIE_COL_DES];
    isfav=map[MOVIE_COL_FAV]==0? false:true;
}


}
