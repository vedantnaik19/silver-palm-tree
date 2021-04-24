// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
    Post({
        this.id,
        this.createdAt,
        this.type,
        this.thumbnail,
        this.likes,
        this.comments,
        this.tags,
    });

    int id;
    int createdAt;
    String type;
    String thumbnail;
    int likes;
    int comments;
    List<String> tags;

    Post copyWith({
        int id,
        int createdAt,
        String type,
        String thumbnail,
        int likes,
        int comments,
        List<String> tags,
    }) => 
        Post(
            id: id ?? this.id,
            createdAt: createdAt ?? this.createdAt,
            type: type ?? this.type,
            thumbnail: thumbnail ?? this.thumbnail,
            likes: likes ?? this.likes,
            comments: comments ?? this.comments,
            tags: tags ?? this.tags,
        );

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"] == null ? null : json["id"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        type: json["type"] == null ? null : json["type"],
        thumbnail: json["thumbnail"] == null ? null : json["thumbnail"],
        likes: json["likes"] == null ? null : json["likes"],
        comments: json["comments"] == null ? null : json["comments"],
        tags: json["tags"] == null ? null : List<String>.from(json["tags"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "createdAt": createdAt == null ? null : createdAt,
        "type": type == null ? null : type,
        "thumbnail": thumbnail == null ? null : thumbnail,
        "likes": likes == null ? null : likes,
        "comments": comments == null ? null : comments,
        "tags": tags == null ? null : List<dynamic>.from(tags.map((x) => x)),
    };
}
