class Goal {
  Map<String, Map<String, dynamic>> contributions;
  String endMonth;
  int endYear;
  int savedAmount;
  String title;
  int totalAmount;

  Goal({
    required this.contributions,
    required this.endMonth,
    required this.endYear,
    required this.savedAmount,
    required this.title,
    required this.totalAmount,
  });

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
      contributions:
          Map<String, Map<String, dynamic>>.from(json['contributions']),
      endMonth: json['end_month'],
      endYear: json['end_year'],
      savedAmount: json['saved_amount'],
      title: json['title'],
      totalAmount: json['total_amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'contributions': contributions,
      'end_month': endMonth,
      'end_year': endYear,
      'saved_amount': savedAmount,
      'title': title,
      'total_amount': totalAmount,
    };
  }

  Goal copyWith({
    Map<String, Map<String, dynamic>>? contributions,
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
      savedAmount: savedAmount ?? this.savedAmount,
      title: title ?? this.title,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }
}
