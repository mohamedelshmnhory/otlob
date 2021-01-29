class Restaurant {
  final id;
  final title;
  final category;
  final description;
  var address;
  final photoUrl;
  final status;
  final distance;
  final lat;
  final long;
  final rate;
  final meals;

  Restaurant(
      {this.id,
      this.title,
      this.category,
      this.description,
      this.address,
      this.photoUrl,
      this.status,
      this.distance,
      this.rate,
      this.meals,
      this.lat,
      this.long});
}
