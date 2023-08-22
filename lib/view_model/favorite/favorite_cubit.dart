import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/main.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());
  List dbData = [];
  deleteFavorite(int? id) async {
    emit(FavoriteLoading());
    await database.deleteDatabaseFromId(id: id);
    emit(FavoriteLoading());
  }

  getFavoriteData() async {
    emit(FavoriteLoading());
    database.getAll().then((value) {
      dbData = value;
    });
    emit(FavoriteLoading());
  }
}
