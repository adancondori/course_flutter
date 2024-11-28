import 'package:course_flutter/page_post/bloc/post_bloc.dart';
import 'package:course_flutter/page_post/bloc/post_event.dart';
import 'package:course_flutter/page_post/bloc/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePosts extends StatefulWidget {
  const HomePosts({super.key});

  @override
  State<HomePosts> createState() => _HomePostsPageState();
}

class _HomePostsPageState extends State<HomePosts> {
  @override
  Widget build(BuildContext context) {
    final postBloc = BlocProvider.of<PostBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('API Example'),
      ),
      body: BlocListener<PostBloc, PostStates>(
        listener: (context, state) {
          //if (state is UpdateState) {}
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("NO se")));
        },
        child: BlocBuilder<PostBloc, PostStates>(
          builder: (context, state) {
            if (state is InitialState) {
              final loginBloc = BlocProvider.of<PostBloc>(context);
              loginBloc.add(ApiPostEvent());
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is UpdateState) {
              return getDetail(state.data);
            }
            return Container();
          },
        ),
      ),
    );
  }

  Center getDetail(List<dynamic> data) {
    var bodyDetail = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //ElevatedButton(
          //  onPressed: fetchData,
          //  child: const Text('Cargar Datos desde la API'),
          //),
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(data[index]['title']),
                  subtitle: Text(data[index]['body']),
                );
              },
            ),
          ),
        ],
      ),
    );
    return bodyDetail;
  }
}
