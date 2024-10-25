import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:pagination_example/model/post_model.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(const PostsState(status: PostsStatus.initial));

  void getPosts() async {
    if (state.page == 1) emit(state.copyWith(status: PostsStatus.loading));
    try {
      var response = await Dio().get('http://10.0.2.2:8000/api/posts',
          queryParameters: {"page": state.page});
      PostModel postModel = PostModel.fromJson(response.data);
      emit(state.copyWith(
        status: PostsStatus.success,
        posts: state.posts == null
            ? postModel
            : PostModel(
                lastPage: postModel.lastPage,
                data: state.posts!.data + postModel.data),
        hasReachedMax: state.page == postModel.lastPage,
        page: state.page + 1,
      ));
    } catch (e) {
      print(e);
      emit(state.copyWith(status: PostsStatus.failure));
    }
    print(
        'state: ${state.status} ,   page ${state.page}  , max ${state.hasReachedMax}');
  }
}
