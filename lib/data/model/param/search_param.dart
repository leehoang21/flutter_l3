class SearchParam {
  final String? keyWord;
  final int? pageIndex;
  final int? size;
  final int? status;

  SearchParam({
    this.keyWord,
    this.pageIndex,
    this.size,
    this.status,
  });

  SearchParam copyWith({
    String? keyWord,
    int? pageIndex,
    int? size,
    int? status,
  }) =>
      SearchParam(
        keyWord: keyWord ?? this.keyWord,
        pageIndex: pageIndex ?? this.pageIndex,
        size: size ?? this.size,
        status: status ?? this.status,
      );

  Map<String, dynamic> toJson() => {
        "keyWord": keyWord,
        "pageIndex": pageIndex,
        "size": size,
        "status": status,
      };
}
