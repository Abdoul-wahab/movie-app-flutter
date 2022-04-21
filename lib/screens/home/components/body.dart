import 'dart:math';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import '../../../components/custom_search.dart';
import '../../../constants.dart';
import '../../details/components/genres.dart';
import '../../details/details_screen.dart';



class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}


class _BodyState extends State<Body> {

  late PageController _pageController;
  int _currentPage = 0;

  var _request;

  var url = Uri.https('api.tvmaze.com', '/shows');

  void getAllShwos() async {
    var url = Uri.https('api.tvmaze.com', '/shows');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse =
        convert.jsonDecode(response.body) as List;
        setState(() {
          _request = jsonResponse;
        });
      }
      print('Request failed with status: ${response.statusCode}.');
    } catch (exception) {
      print(exception.toString());
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    _request = [];
    super.initState();
    _pageController =
        PageController(initialPage: _currentPage, viewportFraction: 0.8);
    getAllShwos();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(40.0),
              child: Center(
                child: Text("Find Your Movie",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontSize: 30)),
              ),
            ),
            Genres(movie:  (_request != null && _request.isNotEmpty) ? _request[_currentPage] : null),
            AspectRatio(
              aspectRatio: 0.85,
              child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      _currentPage = value;
                    });
                  },
                  itemCount: _request.length,
                  physics: const ClampingScrollPhysics(),
                  controller: _pageController,
                  itemBuilder: (context, index) => carouselView(index)
              ),
            )
          ],
        ),
      ),
    );
  }


  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        padding: const EdgeInsets.only(left: kDefaultPadding),
        icon: SvgPicture.asset("assets/icons/menu.svg"),
        onPressed: () {},
      ),
      actions: <Widget>[
        IconButton(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          icon: SvgPicture.asset("assets/icons/search.svg"),
          onPressed: () {
            showSearch(
              context: context,
              delegate: CustomSearchDelegate(),
            );
          },
        ),
      ],
    );
  }

  Widget carouselView(int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 0.0;
        if (_pageController.position.haveDimensions) {
          value = index.toDouble() - (_pageController.page ?? 0);
          value = (value * 0.038).clamp(-1, 1);
          print("value $value index $index");
        }

        return AnimatedOpacity(
          duration: const Duration(milliseconds: 350),
          opacity: _currentPage == index ? 1 : 0.2,
          child: Transform.rotate(
            angle: pi * value,
            child: OpenContainer(
              closedElevation: 0,
              openElevation: 0,
              closedBuilder: (context, action) => carouselCard(_request.isNotEmpty ? _request[index] : null),
              openBuilder: (context, action) => DetailsScreen(movie: _request.isNotEmpty ? _request[index] : null),
            ),
          ),
        );
      },
    );
  }


  Column carouselCard(data) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Hero(
              tag: data['name'],
              child: GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                          image: NetworkImage(
                            data['image']['original'],
                          ),
                          fit: BoxFit.fill),
                      boxShadow: const [kDefaultShadow]),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            data['name'],
            style: const TextStyle(
                color: Colors.black45,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              "assets/icons/star_fill.svg",
              height: 20,
            ),
            const SizedBox(width: 10.0),
            Text(
              "${data['rating']['average']}",
              style: Theme.of(context).textTheme.bodyText2,
            )
          ],
        )
      ],
    );
  }

}
