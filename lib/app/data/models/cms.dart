class CMSModel {
  late int id;
  late String content;
  late String pageTitle;
  late String htmlContent;

  CMSModel({
    required this.id,
    required this.content,
    required this.pageTitle,
    required this.htmlContent,
  });

  CMSModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'] ?? '';
    pageTitle = json['page_title'] ?? '';
    htmlContent = json['html_content'] ?? '';
  }

  static List<CMSModel> listFromJson(list) => List<CMSModel>.from(list.map((x) => CMSModel.fromJson(x)));
}
