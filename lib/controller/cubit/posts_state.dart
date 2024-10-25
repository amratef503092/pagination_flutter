part of 'posts_cubit.dart';

enum PostsStatus { initial, loading, success, failure }

extension PostsStatusX on PostsStatus {
  bool get isInitial => this == PostsStatus.initial;
  bool get isLoading => this == PostsStatus.loading;
  bool get isSuccess => this == PostsStatus.success;
  bool get isFailure => this == PostsStatus.failure;
}

class PostsState {
  final PostsStatus status;
  final PostModel? posts;
  final bool hasReachedMax;
  final int page;

  const PostsState({
    this.status = PostsStatus.initial,
    this.posts,
    this.hasReachedMax = false,
    this.page = 1,
  });

  PostsState copyWith
  ({
    PostsStatus? status,
    PostModel? posts,
    bool? hasReachedMax,
    int? page,
  }) {
    return PostsState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
    );
  }
}
