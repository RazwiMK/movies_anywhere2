import 'package:flutter/material.dart';
import 'package:movies_anywhere/json/search_json.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  Widget getAppBar() {
    var size = MediaQuery.of(context).size;
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      title: Container(
        width: size.width,
        height: 35,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey.withOpacity(0.25)),
        child: TextField(
          style: TextStyle(color: Colors.white.withOpacity(0.5)),
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Search",
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              )),
        ),
      ),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 18, right: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Top Searches",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 12,
            ),
            Column(
                children: List.generate(searchJson.length, (index) {
              return GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Container(
                        width: (size.width - 36) * 0.8,
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 70,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              searchJson[index]['img']),
                                          fit: BoxFit.cover)),
                                ),
                                Container(
                                    height: 70,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.2)))
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: (size.width - 30) * 0.4,
                              child: Text(
                                searchJson[index]['title'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }))
          ],
        ),
      ),
    );
  }
}
