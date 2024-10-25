import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_example/controller/cubit/posts_cubit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (!context.read<PostsCubit>().state.hasReachedMax) {
        context.read<PostsCubit>().getPosts();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Demo'),
        ),
        body: BlocBuilder<PostsCubit, PostsState>(
          builder: (context, state) {
            switch (state.status) {
              case PostsStatus.initial || PostsStatus.loading:
                return const Center(child: CircularProgressIndicator());

              case PostsStatus.success:
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: state.hasReachedMax
                      ? state.posts!.data.length
                      : state.posts!.data.length + 1,
                  itemBuilder: (context, index) {
                    if (index == state.posts!.data.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ListTile(
                        leading: Text(state.posts!.data[index].id.toString()),
                        subtitle: Text(state.posts!.data[index].body),
                        title: Text(state.posts!.data[index].title));
                  },
                );
              case PostsStatus.failure:
                return const Center(child: Text('Failed to fetch posts'));

              default:
                return const Center(child: Text('Something went wrong'));
            }
          },
        ));
  }
}
