import 'package:bloc/bloc.dart';
import 'package:wallpaper_app/model/photo_model/photo_model.dart';
import 'package:wallpaper_app/services/networking/get_photo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  List<Photos> photoList = [];
  getPhotoHome() async {
    emit(HomeLoading());
    photoList = await ApiPhoto().fetchPhotos();

    emit(HomeSuccess());
  }
}
