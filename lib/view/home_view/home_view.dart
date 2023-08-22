import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/classes/navigator/navigator.dart';
import 'package:wallpaper_app/classes/search_image/search.dart';
import 'package:wallpaper_app/constants/icons/icons.dart';
import 'package:wallpaper_app/constants/string/strings_manager.dart';
import 'package:wallpaper_app/view/favorite_view/favorite.dart';
import 'package:wallpaper_app/view_model/home/home_cubit.dart';
import 'package:wallpaper_app/widget/custem_text.dart';

import '../details_view/details_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
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
        BlocProvider(
            create: (context) => HomeCubit()..getPhotoHome(),
            child: BlocConsumer<HomeCubit, HomeState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is HomeLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Scaffold(
                    backgroundColor: Colors.transparent,
                    body: CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          floating: true,
                          centerTitle: false,
                          title: const CustemText(
                              text: AppString.discover, fontSize: 20),
                          actions: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                  onPressed: () {
                                    AppNavigator().appAnimationNavigator(
                                        context, const Favorite());
                                  },
                                  icon: const Icon(
                                    AppIcons.favorite,
                                    color: Colors.red,
                                  )),
                            )
                          ],
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .background
                              .withOpacity(0.1),
                          elevation: 0,
                          bottom: PreferredSize(
                            preferredSize: const Size.fromHeight(70),
                            child: Container(
                              height: 90,
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  margin: const EdgeInsets.all(16),
                                  child: GestureDetector(
                                    onTap: () {
                                      showSearch(
                                          context: context,
                                          delegate: DataSearch(context
                                              .read<HomeCubit>()
                                              .photoList));
                                    },
                                    child: Row(
                                      children: [
                                        const Icon(AppIcons.search),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          AppString.searchKeywordNature,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: GridView.builder(
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            primary: false,
                            shrinkWrap: true,
                            itemCount:
                                context.read<HomeCubit>().photoList.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(
                                  right: 2, bottom: 1, left: 2, top: 1),
                              child: InkWell(
                                onTap: () {
                                  AppNavigator().appAnimationNavigator(
                                    context,
                                    DetailsView(
                                      image: context
                                          .read<HomeCubit>()
                                          .photoList[index]
                                          .src!
                                          .medium
                                          .toString(),
                                      url: context
                                          .read<HomeCubit>()
                                          .photoList[index]
                                          .url
                                          .toString(),
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    context
                                        .read<HomeCubit>()
                                        .photoList[index]
                                        .src!
                                        .medium
                                        .toString(),
                                    fit: BoxFit.fill,
                                  ),
                                ),

                                // child: Image.network(
                                //   context.read<HomeCubit>().photos[index]['src']
                                //       ['tiny'],
                                //   fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            )),
      ],
    );
  }
}
