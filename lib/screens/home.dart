import 'package:ecommerce_app/consts/colors.dart';
import 'package:ecommerce_app/inner_screens/brands_navigation_rail.dart';
import 'package:ecommerce_app/provider/products.dart';
import 'package:ecommerce_app/screens/popular_products.dart';
import 'package:ecommerce_app/widgets/backlayer.dart';
import 'package:ecommerce_app/widgets/category.dart';
import 'package:flutter/material.dart';
import 'package:backdrop/backdrop.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int activeIndex = 0;

  List _carouselIcons = [
    'https://cdn.pixabay.com/photo/2021/12/11/07/59/hotel-6862159__340.jpg',
    'https://cdn.pixabay.com/photo/2021/01/06/09/19/dresden-5893714__340.jpg',
    'https://cdn.pixabay.com/photo/2021/12/28/04/12/snow-6898585__340.jpg',
    'https://cdn.pixabay.com/photo/2021/12/19/10/42/old-6880626__340.jpg',
    'https://cdn.pixabay.com/photo/2021/12/21/09/40/dogs-6884916__340.jpg'
  ];

  List _brandImages = [
    'https://cdn.pixabay.com/photo/2021/12/11/07/59/hotel-6862159__340.jpg',
    'https://cdn.pixabay.com/photo/2021/01/06/09/19/dresden-5893714__340.jpg',
    'https://cdn.pixabay.com/photo/2021/12/28/04/12/snow-6898585__340.jpg',
    'https://cdn.pixabay.com/photo/2021/12/19/10/42/old-6880626__340.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final popularItems = productsData.popularProducts;
    return Scaffold(
      body: BackdropScaffold(
        frontLayerBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        headerHeight: MediaQuery.of(context).size.height * 0.25,
        appBar: BackdropAppBar(
          title: Text('Home'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [ColorConsts.starterColor, ColorConsts.endcolor])),
          ),
          actions: <Widget>[
            IconButton(
              iconSize: 10,
              padding: const EdgeInsets.all(10),
              icon: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 13,
                  backgroundImage: NetworkImage('https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg'),
                ),
              ),
              onPressed: () {},
            )
          ],
        ),
        backLayer: BackLayerMenu(),
        frontLayer: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 250.0,
                  width: double.infinity,
                  child: Column(
                    children: [
                      //--------------------------CAROUSEL--------------------------------------
                      CarouselSlider.builder(
                        options: CarouselOptions(
                          height: 190,
                          //1 PICTURE AT A TIME
                          //viewportFraction: 1,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          //pageSnapping: false,
                          //enableInfiniteScroll: false,
                          //rev erse: true
                          //reverse: true,
                          autoPlayInterval: Duration(seconds: 5),
                          onPageChanged: (index, reason) =>
                              setState(() => activeIndex = index),
                        ),
                        itemCount: _carouselIcons.length,
                        itemBuilder: (context, index, realIndex) {
                          final icon = _carouselIcons[index];
                          return buildImage(icon, index);
                        },
                      ),
                      const SizedBox(height: 32),
                      buildIndicator(),
                    ],
                  ),
                ),
              ),
              //SizedBox(height:80),
              //--------------------------CATEGORIES WIDGET--------------------------------------
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Categories',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                ),
              ),
              Container(
                width: double.infinity,
                height: 180,
                child: ListView.builder(
                    itemCount: 7,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext ctx, int index) {
                      return CategoryWidget(index: index);
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Popular Brands',
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                    ),
                    Spacer(),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          BrandNavigationRailScreen.routeName,
                          arguments: {
                            7,
                          },
                        );
                      },
                      child: Text('View all',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: Colors.purple),
                      ),
                    )
                  ],
                ),
              ),
              //--------------------------SWIPER--------------------------------------
              Container(
                height: 210,
                width: MediaQuery.of(context).size.width * 0.95,
                child: Swiper(
                  itemCount: _brandImages.length,
                  autoplay: true,
                  viewportFraction: 0.8,
                  scale: 0.9,
                  onTap: (index) {
                    Navigator.of(context).pushNamed(
                      BrandNavigationRailScreen.routeName,
                      arguments: {
                        index,
                      },
                    );
                  },
                  itemBuilder: (BuildContext ctx, int index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        color: Colors.blueGrey,
                        child: Image.network(
                          _brandImages[index],
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                ),
              ),
              //--------------------------POPULAR PRODUCT WIDGET-------------------------------------
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text('Popular Products',
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                    ),
                    Spacer(),
                    FlatButton(
                      onPressed: () {},
                      child: Text('View all',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: Colors.purple),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 300,
                margin: EdgeInsets.symmetric(horizontal: 3),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: popularItems.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return ChangeNotifierProvider.value(
                        value: popularItems[index],
                        child: PopularProducts(
                          // imageUrl: popularItems[index].imageUrl,
                          // title: popularItems[index].title,
                          // description: popularItems[index].description,
                          // price: popularItems[index].price,
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage(String icon, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        color: Colors.grey,
        child: Image.network(
          icon,
          fit: BoxFit.cover,
        ), // Image.network
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: _carouselIcons.length,
        effect: SlideEffect(
          dotWidth: 15,
          dotHeight: 15,
          activeDotColor: Colors.purple,
          dotColor: Colors.black12,
        ), // SlideEffect
      );
}
