import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  // to use the same value of cubit everywhere
  static AppCubit get(context)=>BlocProvider.of(context);

  late Map<int,int> savedUserAnswers;

  void saveUserAnswers({required Map<int,int> screenResult}){
    savedUserAnswers = screenResult;
    emit(SetUserAnswers());
  }
}
