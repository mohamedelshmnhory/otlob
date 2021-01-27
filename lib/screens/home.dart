import 'package:flutter/material.dart';
import 'package:otlob/models/restaurant.dart';
import 'package:otlob/providers/retaurants.dart';
import 'package:otlob/screens/restaurant_details.dart';
import 'package:otlob/widgets/app_drawer.dart';
import 'package:otlob/widgets/pageTurn.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  TextEditingController _editingController = TextEditingController();
  bool _isInit = true;
  bool _isLoading = false;
  bool _showSearch = false;
  String filter = '';
  int length = 0;
  var _items = List();
  List<Restaurant> _restaurants = [];
  List<String> _categories = [];

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Restaurants>(context, listen: false)
          .fetchRestaurants()
          .then((_) {
        _restaurants =
            Provider.of<Restaurants>(context, listen: false).restaurants;
        _categories =
            Provider.of<Restaurants>(context, listen: false).categories;
        setState(() {
          _isLoading = false;
        });
      });
    }
    setState(() {
      _isInit = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    filterSearch(String query) {
      print(_items.length);
      List<Restaurant> searchList = List<Restaurant>();
      var initList =
          Provider.of<Restaurants>(context, listen: false).restaurants;
      // .where((prod) => prod.category == categoryTitle)
      // .toList();
      // var showItemList = Provider.of<Products>(context, listen: false).items;
      searchList.addAll(initList);
      if (query.isNotEmpty) {
        List<Restaurant> resultListData = List<Restaurant>();
        searchList.forEach((item) {
          if (item.title.toLowerCase().contains(query.toLowerCase())) {
            resultListData.add(item);
          }
        });
        setState(() {
          _items.clear();
          _items.addAll(resultListData);
        });
        return;
      } else {
        setState(() {
          _items.clear();
          _items.addAll(initList);
        });
      }
    }

    if (filter == '') {
      {
        _items = _restaurants;
      }
    } else {
      _items =
          _restaurants.where((element) => element.category == filter).toList();
    }
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _drawerKey,
      endDrawer: AppDrawer(),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height * .16,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: Color(0xffFFC501),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.menu,
                            size: 25,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            _drawerKey.currentState.openEndDrawer();
                          }),
                      if (!_showSearch)
                        Text(
                          'الرئيسية',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      Container(
                        child: _showSearch
                            ? Row(
                                children: [
                                  Container(
                                    width: size.width * .65,
                                    child: TextFormField(
                                      // style: Theme.of(context).textTheme.headline6,
                                      controller: _editingController,
                                      cursorColor: Colors.black,
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        hintText: "بحث",
                                      ),
                                      onChanged: (value) {
                                        filterSearch(value);
                                      },
                                    ),
                                  ),
                                  IconButton(
                                    tooltip: 'Clear',
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      setState(() {
                                        _showSearch = false;
                                      });
                                      filterSearch('');
                                      _editingController.clear();
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                    },
                                  ),
                                ],
                              )
                            : IconButton(
                                icon: Icon(
                                  Icons.search,
                                  size: 25,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _showSearch = true;
                                  });
                                }),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 15, top: 25),
                child: Text(
                  'مرحبا\nعن ماذا تبحث ؟',
                  style: TextStyle(
                    fontSize: 27,
                    color: Color.fromRGBO(70, 32, 11, 1),
                  ),
                ),
              ),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Container(
                          height: size.height * .075,
                          width: size.width,
                          margin:
                              EdgeInsets.only(right: 10, top: 10, bottom: 10),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: OutlineButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    setState(() {
                                      filter = '';
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: '' == filter
                                            ? Color(0xffEF2823)
                                            : Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    height: size.height * .05,
                                    width: size.width * .3,
                                    child: Center(
                                      child: Text(
                                        'الجميع',
                                        style: TextStyle(
                                          color: '' == filter
                                              ? Colors.white
                                              : Color(0xffEF2823),
                                        ),
                                      ),
                                    ),
                                  ),
                                  borderSide: BorderSide(
                                      color: Color(0xffEF2823),
                                      width: 2,
                                      style: BorderStyle.solid),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  // disabledBorderColor: Color(0xffEF2823),
                                ),
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _categories.length,
                                  itemBuilder: (ctx, i) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: OutlineButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            setState(() {
                                              filter = _categories[i];
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: _categories[i] == filter
                                                    ? Color(0xffEF2823)
                                                    : Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            height: size.height * .05,
                                            width: size.width * .3,
                                            child: Center(
                                              child: Text(
                                                _categories[i],
                                                style: TextStyle(
                                                  color:
                                                      _categories[i] == filter
                                                          ? Colors.white
                                                          : Color(0xffEF2823),
                                                ),
                                              ),
                                            ),
                                          ),
                                          borderSide: BorderSide(
                                              color: Color(0xffEF2823),
                                              width: 2,
                                              style: BorderStyle.solid),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          // disabledBorderColor: Color(0xffEF2823),
                                        ),
                                      )),
                            ],
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: _items.length,
                          itemBuilder: (ctx, i) {
                            return GestureDetector(
                              onTap: () {
                                pageTurn(RestaurantDetails(_items[i]), context);
                              },
                              child: Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(8),
                                          height: 108.16,
                                          width: 119.39,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      _items[i].photoUrl),
                                                  fit: BoxFit.cover)),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _items[i].title,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                            Container(
                                              height: size.height * .05,
                                              width: size.width * .4,
                                              child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount:
                                                      _items[i].rate.round(),
                                                  itemBuilder: (ctx, i) => Icon(
                                                        Icons.star,
                                                        color: Colors.yellow,
                                                      )),
                                            ),
                                            Text(
                                              _items[i].description,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 12,
                                                  color: Color(0xff787878)),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Icon(Icons.location_on,
                                                    color: Color(0xff787878)),
                                                Text(
                                                  '${_items[i].address}  - ${_items[i].distance} ك.م ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 12,
                                                      color: Color(0xff787878)),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.directions_car_sharp,
                                                    color: Color(0xff787878)),
                                                Text(
                                                  _items[i].status,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 12,
                                                      color: Color(0xff787878)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      thickness: .5,
                                      indent: 20,
                                      endIndent: 20,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
