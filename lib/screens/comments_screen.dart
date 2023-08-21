import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/comment_card.dart';

import '../utils/colors.dart';

class CommentsScreenState extends StatefulWidget {
  const CommentsScreenState({super.key});

  @override
  State<CommentsScreenState> createState() => _CommentsScreenStateState();
}

class _CommentsScreenStateState extends State<CommentsScreenState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text('Comments Screen'),
        centerTitle: false,
      ),
      body: CommentCard(),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1691874683123-5d7bf8d79df1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw3MXx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
                ),
                radius: 18,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 8),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'メッセージを追加',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: const Text(
                      '投稿',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
