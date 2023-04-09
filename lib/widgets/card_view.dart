import 'package:flutter/material.dart';
import '../model/recipes.dart';
import 'package:provider/provider.dart';

class CardView extends StatelessWidget {
  final int idx;

  const CardView({required this.idx, super.key});

  @override
  Widget build(BuildContext context) {
    final recipe = Provider.of<Recipes>(context).popular[idx];
    return InkWell(
      onTap: () {},
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    recipe.imgUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Text('Your error widget...');
                    },
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    width: 330,
                    color: Colors.black54,
                    child: Text(
                      recipe.label,
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.all(20),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //       Row(
            //         children: [
            //           Icon(Icons.schedule),
            //           SizedBox(
            //             width: 6,
            //           ),
            //           Text('${duration} min'),
            //         ],
            //       ),
            //       Row(
            //         children: [
            //           Icon(Icons.work),
            //           SizedBox(
            //             width: 6,
            //           ),
            //           Text('$complexityText'),
            //         ],
            //       ),
            //       Row(
            //         children: [
            //           Icon(Icons.attach_money),
            //           SizedBox(
            //             width: 6,
            //           ),
            //           Text('$affordabilityText'),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
