class Goal {
  Map<String, int> contributions;
  String endMonth;
  int endYear;
  String title;
  int totalAmount;

  Goal({
    required this.contributions,
    required this.endMonth,
    required this.endYear,
    required this.title,
    required this.totalAmount,
  });

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
      contributions: Map<String, int>.from(json['contributions']),
      endMonth: json['end_month'],
      endYear: json['end_year'],
      title: json['title'],
      totalAmount: json['total_amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'contributions': contributions,
      'end_month': endMonth,
      'end_year': endYear,
      'title': title,
      'total_amount': totalAmount,
    };
  }

  Goal copyWith({
    Map<String, int>? contributions,
    String? endMonth,
    int? endYear,
    int? savedAmount,
    String? title,
    int? totalAmount,
  }) {
    return Goal(
      contributions: contributions ?? this.contributions,
      endMonth: endMonth ?? this.endMonth,
      endYear: endYear ?? this.endYear,
      title: title ?? this.title,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}
