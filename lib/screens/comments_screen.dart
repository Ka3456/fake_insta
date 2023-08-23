import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user.dart';
import 'package:flutter_application_1/resources/firestore_methods.dart';
import 'package:flutter_application_1/widgets/comment_card.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../utils/colors.dart';

class CommentsScreen extends StatefulWidget {
  final snap;
  const CommentsScreen({super.key, required this.snap});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  //なんか後からの追加
  final TextEditingController _commentEditingController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _commentEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //userの情報を取得
    final User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text('Comments Screen'),
        centerTitle: false,
      ),
      body: StreamBuilder(

          //このcollectionでデータを取得する時のファイル名を指定してる
          stream: FirebaseFirestore.instance
              .collection('posts')
              .doc(widget.snap['postId'])
              .collection('comments')
              .orderBy('datePublished', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              //コメントの数を確認
              itemCount: (snapshot.data! as dynamic).docs.length,
              itemBuilder: (context, index) => CommentCard(
                  snap: (snapshot.data! as dynamic).docs[index].data()),
            );
          }),
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
                  user.photoUrl,
                ),
                radius: 18,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 8),
                  child: TextField(
                    controller: _commentEditingController,
                    decoration: InputDecoration(
                      hintText: '${user.username}としてコメントする',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  await FirestoreMethods().postComment(
                    widget.snap['postId'],
                    _commentEditingController.text,
                    user.uid,
                    user.username,
                    user.photoUrl,
                  );

                  setState(() {
                    _commentEditingController.text = '';
                  });
                },
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
