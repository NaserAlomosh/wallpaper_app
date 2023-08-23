import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/classes/navigator/navigator.dart';
import 'package:wallpaper_app/constants/icons/icons.dart';
import 'package:wallpaper_app/constants/string/strings_manager.dart';
import 'package:wallpaper_app/main.dart';
import 'package:wallpaper_app/view/details_view/details_view.dart';
import 'package:wallpaper_app/widget/custem_text.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  List dbData = [];
  @override
  void initState() {
    database.getAll().then((value) {
      setState(() {
        dbData = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = FixedExtentScrollController();

    return Stack(
      children: [
        Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Theme.of(context).colorScheme.background,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_sharp)),
              title: const CustemText(text: AppString.favorire, fontSize: 20),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: dbData.isEmpty
                ? const Center(
                    child: CustemText(
                        text: AppString.favoriteIsEmpty, fontSize: 35),
                  )
                : ClickableListWheelScrollView(
                    animationDuration: const Duration(seconds: 1),
                    scrollController: scrollController,
                    itemHeight: 500,
                    itemCount: dbData.length,
                    onItemTapCallback: (index) {},
                    child: ListWheelScrollView.useDelegate(
                      controller: scrollController,
                      itemExtent: MediaQuery.of(context).size.height / 2,
                      physics: const FixedExtentScrollPhysics(),
                      overAndUnderCenterOpacity: 0.6,
                      perspective: 0.002,
                      onSelectedItemChanged: (index) {},
                      childDelegate: ListWheelChildBuilderDelegate(
                        builder: (context, index) {
                          return Stack(
                            children: [
                              GestureDetector(
                                onTap: () => AppNavigator()
                                    .appAnimationNavigator(
                                        context,
                                        DetailsView(
                                            image: dbData[index]['image'],
                                            titleSaveDb: dbData[index]
                                                ['image'])),
                                child: Container(
                                  height: 500,
                                  width: double.infinity,
                                  color: Colors.amber,
                                  child: dbData[index]['image'].isEmpty
                                      ? Container()
                                      : Image.network(
                                          dbData[index]['image'],
                                          fit: BoxFit.fill,
                                        ),
                                ),
                              ),
                              // CustemText(
                              //     text: dbData[index]['title'].toString(),
                              //     fontSize: 18),
                              Positioned(
                                  right: 0,
                                  child: IconButton(
                                      onPressed: () async {
                                        if (dbData.isNotEmpty) {
                                          for (var data in dbData) {
                                            if (data['image'] ==
                                                dbData[index]['image']) {
                                              database
                                                  .deleteDatabaseFromImage(
                                                      image: data['image'])
                                                  .then((value) {
                                                database.getAll().then((value) {
                                                  setState(() {
                                                    dbData = value;
                                                  });
                                                });
                                              });
                                            }
                                          }
                                        }
                                      },
                                      icon: const CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          AppIcons.favorite,
                                          color: Colors.red,
                                        ),
                                      )))
                            ],
                          );
                        },
                        childCount: dbData.length,
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
