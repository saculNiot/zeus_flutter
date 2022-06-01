class GetReportTypeResponse {
  List<ReportType>? reportTypes;

  GetReportTypeResponse({this.reportTypes});

  GetReportTypeResponse.fromJson(Map<String, dynamic> json) {
    if (json['ReportType'] != null) {
      reportTypes = [];
      json['ReportType'].forEach((v) {
        reportTypes!.add(new ReportType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reportTypes != null) {
      data['ReportType'] = this.reportTypes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SaveTicket {
  String? userId;
  String? ticketType;
  String? issueDesc;
  String? accuserId;
  String? accuserType;

  SaveTicket({
    this.userId,
    this.ticketType,
    this.issueDesc,
    this.accuserId,
    this.accuserType,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['ticketType'] = this.ticketType;
    data['issueDesc'] = this.issueDesc;
    data['accuserId'] = this.accuserId;
    data['accuserType'] = this.accuserType;

    return data;
  }
}

class ReportType {
  String? reportTypeId;
  String? reportName;
  String? reportDesc;

  ReportType({
    this.reportTypeId,
    this.reportName,
    this.reportDesc,
  });

  ReportType.fromJson(Map<String, dynamic> json) {
    reportTypeId = json['report_type_id'];
    reportName = json['name'];
    reportDesc = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reportTypeId'] = this.reportTypeId;
    data['name'] = this.reportName;
    data['description'] = this.reportDesc;

    return data;
  }
}

class GetReportDetailResponse {
  List<ReportDetail>? reportDetails;

  GetReportDetailResponse({this.reportDetails});

  GetReportDetailResponse.fromJson(Map<String, dynamic> json) {
    if (json['ReportDetails'] != null) {
      reportDetails = [];
      json['ReportDetails'].forEach((v) {
        reportDetails!.add(new ReportDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reportDetails != null) {
      data['ReportDetails'] = this.reportDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReportDetail {
  String? reportDetailId;
  String? reportDetailName;
  String? reportTypeId;
  String? reportDetailDesc;

  ReportDetail({
    this.reportDetailId,
    this.reportDetailName,
    this.reportTypeId,
    this.reportDetailDesc,
  });

  ReportDetail.fromJson(Map<String, dynamic> json) {
    reportDetailId = json['report_detail_id'];
    reportDetailName = json['name'];
    reportTypeId = json['report_type_id'];
    reportDetailDesc = json['description'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reportDetailId'] = this.reportDetailId;
    data['name'] = this.reportDetailName;
    data['reportTypeId'] = this.reportTypeId;
    data['description'] = this.reportDetailDesc;

    return data;
  }
}
