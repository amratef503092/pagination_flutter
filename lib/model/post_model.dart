class PostModel {
  int lastPage;
  List<BasePostModel> data;

  PostModel({required this.lastPage, required this.data});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<BasePostModel> dataList =
        list.map((i) => BasePostModel.fromJson(i)).toList();

    return PostModel(
      lastPage: json['last_page'],
      data: dataList,
    );
  }
}

class BasePostModel {
  int id;
  String title;
  String body;

  BasePostModel({required this.id, required this.title, required this.body});

  factory BasePostModel.fromJson(Map<String, dynamic> json) {
    return BasePostModel(
      id: json['id'],
      title: json['title'],
      body: json['content'],
    );
  }
}
