import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:receipe_app/custom_appbar.dart';
import 'package:receipe_app/model/recipes.dart';
import 'package:receipe_app/recipe_page.dart';
import 'package:receipe_app/widgets/card_view.dart';
import 'package:receipe_app/widgets/final_card_view.dart';

import 'model/recipe.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search-page';
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _isLoad = false;
  var _isTrue = false;
  List<String?> finalList = [];
  @override
  void initState() {
    setState(() {
      _isLoad = true;
    });
    Provider.of<Recipes>(context, listen: false).initialFetch().then((value) {
      setState(() {
        _isLoad = false;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var dataProvider = Provider.of<Recipes>(context, listen: true);
    List<Data?> ing = [];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar:
      appBar: const CustomAppBar(),
      body: _isLoad
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: height * 0.3,
                          padding: EdgeInsets.all(20),
                          child: MultiSelectDialogField<Data>(
                            separateSelectedItems: true,
                            dialogHeight: height * 0.4,
                            onConfirm: (values) {
                              ing = values;
                              setState(() {
                                _isTrue = true;
                              });
                              Provider.of<Recipes>(context, listen: false)
                                  .getList(ing);
                            },
                            searchable: true,
                            items: [
                              ...Provider.of<Recipes>(context, listen: true)
                                  .ingredients
                                  .map((e) => MultiSelectItem(e, e.val!))
                            ],
                            initialValue: const [],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text("Recipe Result",
                              style: TextStyle(
                                  color: Colors.purple, fontSize: 20)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
                body: FutureBuilder(
                  future: Provider.of<Recipes>(context).getReq(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Recipe>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return FinalCarView(
                              idx: index,
                            );
                          },
                          itemCount: (snapshot.data!.length < 9)
                              ? snapshot.data!.length
                              : 9,
                        );
                      }
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
