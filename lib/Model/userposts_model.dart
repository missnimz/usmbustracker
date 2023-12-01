class UserPostList{
  Meta? meta;
  List<UserPost>? data;

  UserPostList({this.meta, this.data});

  UserPostList.fromJson(Map<String, dynamic> json){
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['data'] != null){
      data = [];
      json['data'].forEach((v) {
        data!.add(UserPost.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    if (meta != null){
      data['meta'] = meta!.toJson();
    }
    if (this.data != null){
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserPost{
  int? id;
  String? image_url;
  String? uploaded_at;
  int? user_id;
  String? caption;

  UserPost({
    this.id,
    this.image_url,
    this.uploaded_at,
    this.user_id,
    this.caption,
  });

  UserPost.fromJson(Map<String, dynamic> json){
    id = json['id'];
    image_url = json['image_url'];
    uploaded_at = json['uploaded_at'];
    user_id = json['user_id'];
    caption = json['caption'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image_url'] = image_url;
    data['uploaded_at'] = uploaded_at;
    data['user_id'] = user_id;
    data['caption'] = caption;
    return data;
  }
}

class Meta{
  int? page;
  int? perPage;
  int? pageCount;
  int? totalCount;

  Meta({this.page, this.perPage, this.pageCount, this.totalCount});

  Meta.fromJson(Map<String, dynamic> json){
    page = json['page'];
    perPage = json['per_page'];
    pageCount = json['page_count'];
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['per_page'] = perPage;
    data['page_count'] = pageCount;
    data['total_count'] = totalCount;
    return data;
  }
}