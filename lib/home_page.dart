import 'package:flutter/material.dart';
import 'package:receipe_app/search.dart';
import 'package:provider/provider.dart';
import 'package:receipe_app/widgets/card_view.dart';
import 'custom_appbar.dart';
import './model/recipes.dart';
import 'model/recipe.dart';

class HomePage extends StatefulWidget {
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
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          const Text(
            'Popular Recipes',
            style: TextStyle(
              color: Colors.purple,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FutureBuilder(
            future:
                Provider.of<Recipes>(context, listen: false).popularRecipe(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Recipe>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return CardView(
                          idx: index,
                        );
                      },
                      itemCount: Provider.of<Recipes>(context).getLength(),
                    ),
                  );
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.search,
          color: Colors.purple,
        ),
        onPressed: () => Navigator.of(context).pushNamed(SearchPage.routeName),
      ),
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
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.white,
      //   child: const Icon(
      //     Icons.search,
      //     color: Colors.purple,
      //   ),
      //   onPressed: () => Navigator.of(context).pushNamed(SearchPage.routeName),
      // ),
    );
  }
}
