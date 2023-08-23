import 'package:flutter/material.dart';
import 'package:search_page/search_page.dart';
import 'package:wallpaper_app/classes/navigator/navigator.dart';
import 'package:wallpaper_app/main.dart';
import 'package:wallpaper_app/view/details_view/details_view.dart';
import 'package:wallpaper_app/widget/custem_text.dart';

import '../../model/photo_model/photo_model.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
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
          Scaffold(
            backgroundColor: Colors.transparent,

            //t.alt.toString()

            body: ListView.builder(
              itemCount: photos.length,
              itemBuilder: (context, index) {
                return Stack(children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Center(
                      child: Image.network(
                        '${photos[index].src!.medium}',
                        fit: BoxFit.fitHeight,
                        width: MediaQuery.of(context).size.width / 1,
                      ),
                    ),
                  ),
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context)
                              .colorScheme
                              .background
                              .withOpacity(0.6)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustemText(
                            text: photos[index].alt.toString(), fontSize: 16),
                      ),
                    ),
                  ))
                ]);
              },
            ),
            floatingActionButton: FloatingActionButton.large(
              backgroundColor:
                  Theme.of(context).colorScheme.background.withOpacity(0.6),
              tooltip: 'Search people',
              onPressed: () => showSearch(
                useRootNavigator: true,
                context: context,
                delegate: SearchPage<Photos>(
                  onQueryUpdate: print,
                  items: photos,
                  barTheme: ThemeData(
                      appBarTheme: AppBarTheme(
                          elevation: 0,
                          backgroundColor:
                              Theme.of(context).colorScheme.background)),
                  searchLabel: 'Search people',
                  suggestion: Scaffold(
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
                  failure: const Center(
                    child: Text('Not found'),
                  ),
                  filter: (person) => [
                    person.alt,
                  ],
                  builder: (Photos t) {
                    database.getAll().then((value) {
                      setState(() {
                        var dbData = value;
                        if (dbData.isNotEmpty) {
                          for (var data in dbData) {
                            if (data['image'].isNotEmpty) {
                              if (data['image'] == t.src!.medium) {
                                setState(() {
                                  isFavorite = true;
                                });
                              } else {
                                setState(() {
                                  isFavorite = false;
                                });
                              }
                            }
                          }
                        }
                      });
                    });

                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                AppNavigator().appAnimationNavigator(
                                    context,
                                    DetailsView(
                                        image: t.src!.medium.toString(),
                                        titleSaveDb: t.src!.medium.toString()));
                              },
                              child: Image.network(
                                '${t.src!.medium}',
                                fit: BoxFit.fitHeight,
                                width: MediaQuery.of(context).size.width / 1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              child: const Icon(Icons.search),
            ),
          ),
        ],
      ),
    );
  }
}
