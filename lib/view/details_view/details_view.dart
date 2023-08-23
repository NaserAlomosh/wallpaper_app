import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallpaper_app/classes/save_image/save_image.dart';
import 'package:wallpaper_app/constants/icons/icons.dart';
import 'package:wallpaper_app/constants/string/strings_manager.dart';
import 'package:wallpaper_app/main.dart';
import 'package:wallpaper_app/widget/custem_text.dart';

class DetailsView extends StatefulWidget {
  final String image;
  final String titleSaveDb;

  const DetailsView({
    super.key,
    required this.image,
    required this.titleSaveDb,
  });

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  List dbData = [];

  //bool isFavorite = false;

  int id = 0;
  _DetailsViewState();

  @override
  void initState() {
    database.getAll().then((value) {
      setState(() {
        dbData = value;
        if (dbData.isNotEmpty) {
          for (var data in dbData) {
            if (data['image'] == widget.image) {
              setState(() {
                isFavorite = true;
              });
            } else {
              isFavorite = false;
            }
          }
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.background.withOpacity(0.8),
                  Theme.of(context).colorScheme.background.withOpacity(0.8)
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    forceElevated: true,
                    elevation: 40,
                    pinned: true,
                    floating: false,
                    shape: const ContinuousRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60),
                      ),
                    ),
                    backgroundColor: Colors.transparent,
                    leading: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(AppIcons.arrowBackIosNewSharp)),
                    title: CustemText(text: AppString.diteals, fontSize: 20.sp),
                    actions: [
                      IconButton(
                          onPressed: () async {
                            dbData = await database.getAll();
                            setState(() {
                              dbData;
                              if (isFavorite == true) {
                                for (var data in dbData) {
                                  if (data['image'] == widget.image) {
                                    database
                                        .deleteDatabaseFromImage(
                                            image: data['image'])
                                        .then((value) {
                                      setState(() {
                                        isFavorite = false;
                                      });
                                    });
                                  }
                                }
                              } else if (isFavorite == false) {
                                database
                                    .insertToDatabase(widget.image, 'true',
                                        'true', widget.titleSaveDb)
                                    .then((value) {
                                  if (isFavorite == true) {
                                    setState(() {
                                      isFavorite = false;
                                      database.getAll();
                                    });
                                  } else {
                                    setState(() {
                                      isFavorite = true;
                                      database.getAll();
                                    });
                                  }
                                });
                              }
                            });
                          },
                          icon: Icon(
                            AppIcons.favorite,
                            color:
                                isFavorite == true ? Colors.red : Colors.white,
                          ))
                    ],
                    expandedHeight: MediaQuery.of(context).size.height / 1,
                    flexibleSpace: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      child: FlexibleSpaceBar(
                        background: Image.network(
                          widget.image,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        onPressed: () {
                          SaveImageToPhone().saveImage(widget.image, context);
                        },
                        icon: const Icon(
                          AppIcons.download,
                          color: Colors.white,
                        )),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
