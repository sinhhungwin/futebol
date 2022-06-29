class Comment {
  String id;
  String postId;
  String email;
  String content;

  Comment({this.id, this.postId, this.email, this.content});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postId = json['post_id'];
    email = json['email'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['post_id'] = postId;
    data['email'] = email;
    data['content'] = content;
    return data;
  }

  @override
  String toString() {
    return 'Comment{id: $id, postId: $postId, email: $email, content: $content}';
  }
}
