import 'package:equatable/equatable.dart';
import '../../../model/postmodel.dart';
import '../../../utils/enum.dart'; // PostStatus enum should be defined here

class PostState extends Equatable {
  final PostStatus postStatus;  // Loading status (loading, success, failure)
  final List<PostModel> postList;  // List of fetched posts
  final String message;  // Message in case of failure or success

  // Initial/default values for the state
  PostState({
    this.postStatus = PostStatus.loading,
    this.postList = const <PostModel>[], // Empty list as default
    this.message = '',  // Empty message as default
  });

  // The copyWith method allows to partially update the state
  PostState copyWith({
    PostStatus? postStatus,
    List<PostModel>? postList,
    String? message,
  }) {
    return PostState(
      postStatus: postStatus ?? this.postStatus,  // Keep current value if not provided
      postList: postList ?? this.postList,
      message: message ?? this.message,
    );
  }

  // Equatable is used for value comparison of states
  @override
  List<Object> get props => [postStatus, postList, message];
}
