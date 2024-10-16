import 'package:database_practice/bloc/post/bloc/post_bloc.dart';
import 'package:database_practice/bloc/post/bloc/post_state.dart';
import 'package:database_practice/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  void initState() {
    super.initState();
    // Fetching posts when screen initializes
    context.read<PostBloc>().add(PostFetch());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API example with Bloc"),
      ),
      body: Column(
        children: [
          const Text("Post API"),
          // Expanded added here to make ListView fill available space
          Expanded(
            child: BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                switch (state.postStatus) {
                  case PostStatus.loading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case PostStatus.failure:
                    return Center(
                      child: Text(state.message.toString()),
                    );
                  case PostStatus.success:
                    return ListView.builder(
                      itemCount: state.postList.length,
                      itemBuilder: (context, index) {
                        final item = state.postList[index];
                        return ListTile(
                          title: Text(item.email.toString()),
                          subtitle: Text(item.body.toString()),
                        );
                      },
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
