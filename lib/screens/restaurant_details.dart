import 'package:flutter/material.dart';
import 'package:otlob/models/meals.dart';
import 'package:otlob/models/restaurant.dart';

class RestaurantDetails extends StatelessWidget {
  final Restaurant restaurant;
  RestaurantDetails(this.restaurant);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Stack(
          children: [
            // Column(
            //   children: [
            //     Expanded(flex: 1, child: Container()),
            //   ],
            // ),
            Scaffold(),
            Container(
              height: size.height * .3,
              width: size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(restaurant.photoUrl),
                      fit: BoxFit.fitWidth)),
              child: Container(
                height: size.height * .3,
                width: size.width,
                color: Colors.black45,
                child: Padding(
                  padding: const EdgeInsets.only(top: 28.0, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 20),
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              )),
                        ),
                      ),
                      Text(
                        restaurant.title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                      Container(
                        height: size.height * .05,
                        width: size.width * .4,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: restaurant.rate.round(),
                            itemBuilder: (ctx, i) => Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 180,
              child: Container(
                height: size.height * .735,
                width: size.width,
                padding: EdgeInsets.only(right: 15, left: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 35,
                      ),
                      Text(
                        restaurant.description,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                            color: Color(0xff46200B)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.location_on, color: Color(0xffEF2823)),
                          Text(
                            restaurant.address,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 19,
                                color: Color(0xff787878)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Divider(
                          thickness: .5,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.access_time, color: Color(0xff0DBF00)),
                          Text(
                            'مفتوح',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 18,
                                color: Color(0xff0DBF00)),
                          ),
                          Text(
                            '- من 10 ص إلى 10 م',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 18,
                                color: Color(0xff787878)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.directions_car_sharp,
                              color: Color(0xff787878)),
                          Text(
                            restaurant.status,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 18,
                                color: Color(0xff787878)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Divider(
                          thickness: .5,
                        ),
                      ),
                      Text(
                        'الأصناف',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 25,
                            color: Color(0xff46200B)),
                      ),
                      Container(
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: restaurant.meals.length,
                          itemBuilder: (ctx, i) {
                            List<Meals> meals = [];
                            restaurant.meals.forEach((element) {
                              meals.add(Meals(
                                title: element['title'],
                                photoUrl: element['photoUrl'],
                                price: element['price'],
                              ));
                            });
                            return Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: GridTile(
                                  child: Image.network(
                                    meals[i].photoUrl,
                                    fit: BoxFit.cover,
                                  ),
                                  footer: Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          meals[i].title,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Color(0xff46200B)),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${meals[i].price.toStringAsFixed(1)} - ج.م',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 15,
                                                  color: Color(0xff787878)),
                                            ),
                                            Icon(
                                              Icons.add_shopping_cart_outlined,
                                              color: Color(0xffEF2823),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2 / 3,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
