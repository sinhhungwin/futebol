
class Post {
  String id;
  String description;
  String picture;
  String email;
  String createdAt;
  String reactionCount;
  String reactionEmails;
  String commentCount;

  Post(
      {this.id,
      this.description,
      this.picture,
      this.email,
      this.createdAt,
        this.reactionCount,
        this.reactionEmails,
      this.commentCount});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    picture = json['picture'];
    email = json['email'];
    createdAt = json['created_at'];
    reactionCount = json['reaction_count'] ?? '0';
    reactionEmails = json['reaction_emails'] ?? '';
    commentCount = json['comment_count'] ?? '0';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['picture'] = picture;
    data['email'] = email;
    data['created_at'] = createdAt;
    return data;
  }

  @override
  String toString() {
    return 'Post{id: $id, description: $description, picture: $picture, email: $email, createdAt: $createdAt}';
  }

  assign(Post post) {
    id = post.id;
    description = post.description;
    picture = post.picture;
    email = post.email;
    createdAt = post.createdAt;
    reactionCount = post.reactionCount;
    reactionEmails = post.reactionEmails;
    commentCount = post.commentCount;
  }
}
