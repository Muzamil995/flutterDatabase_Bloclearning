import 'package:bloc/bloc.dart';
import 'package:database_practice/bloc/post/bloc/post_state.dart';
import 'package:database_practice/repository/post_repository.dart';
import 'package:database_practice/utils/enum.dart';
import 'package:equatable/equatable.dart';

import '../../../model/postmodel.dart';

part 'post_event.dart';
 

class PostBloc extends Bloc<PostEvent, PostState> {
  PostRepository postRepository = PostRepository();
  PostBloc() : super(PostState()) {
    on<PostFetch>(postfetch);
  }
 void postfetch(PostFetch event, Emitter<PostState> emit) async{
   await postRepository.fetchPost().then((onValue) {
    print('Posts fetched successfully');
    emit(state.copyWith(
      postStatus: PostStatus.success,
      postList: onValue,
      message: "success",
    ));
  }).onError((error, stackTrace) {
    print('Error fetching posts: $error');
    emit(state.copyWith(
      postStatus: PostStatus.failure,
      message: error.toString(), // Log the actual error message
    ));
  });
}

}
