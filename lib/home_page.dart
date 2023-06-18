import 'package:flutter/material.dart';
import 'package:receipe_app/book_mark.dart';
import 'package:receipe_app/search.dart';
import 'package:provider/provider.dart';
import 'package:receipe_app/widgets/card_view.dart';
import 'custom_appbar.dart';
import './model/recipes.dart';
import 'model/recipe.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/-home";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _isLoading = false;

  @override
  void initState() {
    // setState(() {
    //   _isLoading = true;
    // });
    // Provider.of<Recipes>(context, listen: false).popularRecipe().then((value) {
    //   setState(() {
    //     _isLoading = false;
    //   });
    // });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            color: Colors.purple,
            onPressed: () =>
                Navigator.of(context).pushNamed(BookMark.routeName),
            icon: Icon(Icons.bookmark),
          ),
        ],
        elevation: 1,
        backgroundColor: Colors.purple[100],
        title: Text('Recipe Finder', style: TextStyle(color: Colors.purple)),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: height * 0.06,
                  padding: EdgeInsets.only(left: 17, top: 13),
                  child: const Text(
                    'Popular Recipes',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 23,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
        body: FutureBuilder(
          future: Provider.of<Recipes>(context, listen: false).popularRecipe(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Recipe>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return CardView(
                      idx: index,
                    );
                  },
                  itemCount: Provider.of<Recipes>(context).getLength(),
                );
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     const Padding(
      //       padding: EdgeInsets.only(left: 17, top: 13),
      //       child: Text(
      //         'Popular Recipes',
      //         style: TextStyle(
      //           color: Colors.purple,
      //           fontSize: 23,
      //         ),
      //       ),
      //     ),
      //     const SizedBox(
      //       height: 10,
      //     ),
      //     FutureBuilder(
      //       future:
      //           Provider.of<Recipes>(context, listen: false).popularRecipe(),
      //       builder:
      //           (BuildContext context, AsyncSnapshot<List<Recipe>> snapshot) {
      //         if (snapshot.connectionState == ConnectionState.done) {
      //           if (snapshot.hasData) {
      //             return Expanded(
      //               child: ListView.builder(
      //                 itemBuilder: (context, index) {
      //                   return CardView(
      //                     idx: index,
      //                   );
      //                 },
      //                 itemCount: Provider.of<Recipes>(context).getLength(),
      //               ),
      //             );
      //           }
      //         }
      //         return const Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       },
      //     ),
      //   ],
      // ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.white,
      //   child: const Icon(
      //     Icons.search,
      //     color: Colors.purple,
      //   ),
      //   onPressed: () => Navigator.of(context).pushNamed(SearchPage.routeName),
      // ),
      // body: _isLoading
      //     ? const Center(
      //         child: CircularProgressIndicator(),
      //       )
      //     : Column(
      //         children: [
      //           Text(
      //             'Popular Recipes',
      //             style: TextStyle(
      //               color: Colors.purple,
      //               fontSize: 20,
      //             ),
      //           ),
      //           SizedBox(
      //             height: 10,
      //           ),
      //           Expanded(
      //             child: ListView.builder(
      //               itemBuilder: (context, index) {
      //                 return CardView(
      //                   idx: index,
      //                 );
      //               },
      //               itemCount: Provider.of<Recipes>(context).getLength(),
      //             ),
      //           ),
      //         ],
      //       ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.search,
          color: Colors.purple,
        ),
        onPressed: () => Navigator.of(context).pushNamed(SearchPage.routeName),
      ),
    );
  }
}
