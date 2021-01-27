class Restaurant {
  final String title;
  final String category;
  final String description;
  final String address;
  final String photoUrl;
  final String status;
  final double distance;
  final double rate;
  final List meals;

  Restaurant(
      {this.title,
      this.category,
      this.description,
      this.address,
      this.photoUrl,
      this.status,
      this.distance,
      this.rate,
      this.meals});
}
