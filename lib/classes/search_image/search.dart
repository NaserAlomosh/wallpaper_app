import 'package:flutter/material.dart';
import 'package:wallpaper_app/model/photo_model/photo_model.dart';

class DataSearch extends SearchDelegate<String> {
  List<Photos> listSearch;

  DataSearch(this.listSearch);
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () {}, icon: const Icon(Icons.search))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        //close(context, result);
      },
      icon: const Icon(Icons.safety_check),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('data');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
        itemCount: listSearch.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: SizedBox(
                height: 40,
                width: 20,
                child: Image.network(
                  listSearch[index].src!.medium.toString(),
                  fit: BoxFit.fill,
                )),
            title: Text(listSearch[index].alt.toString()),
          );
        });
  }
}
