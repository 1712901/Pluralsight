class CourseModel {
  int ID;
  String name;
  String author;
  double rating;
  int numberComment;
  int level;
  DateTime date;
  String image;
  int category;
  bool bookmark = false;
  int size;
  List<String> tags;
  CourseModel(
      {this.image,
      this.ID,
      this.author,
      this.rating,
      this.name,
      this.numberComment,
      this.date,
      this.level,
      this.category,
      this.bookmark,
      this.size,
      this.tags}) {
    this.bookmark = false;
  }
}
