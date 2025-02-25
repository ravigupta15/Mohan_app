class DashboardModel {
  dynamic status;
  dynamic message;
  List<Data>? data;

  DashboardModel({this.status, this.message, this.data});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  List<ScoreDashboard>? scoreDashboard;
  List<Dashboard>? dashboard;
  List<DashboardLastLog>? lastLog;
    List<BannerInfo>? bannerInfo;

  Data({this.scoreDashboard, this.dashboard, this.lastLog});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['score_dashboard'] != null) {
      scoreDashboard = <ScoreDashboard>[];
      json['score_dashboard'].forEach((v) {
        scoreDashboard!.add( ScoreDashboard.fromJson(v));
      });
    }
    if (json['dashboard'] != null) {
      dashboard = <Dashboard>[];
      json['dashboard'].forEach((v) {
        dashboard!.add( Dashboard.fromJson(v));
      });
    }
    if (json['last_log'] != null) {
      lastLog = <DashboardLastLog>[];
      json['last_log'].forEach((v) {
        lastLog!.add( DashboardLastLog.fromJson(v));
      });
    }
    if (json['banner_info'] != null) {
      bannerInfo = <BannerInfo>[];
      json['banner_info'].forEach((v) {
        bannerInfo!.add(new BannerInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (scoreDashboard != null) {
      data['score_dashboard'] =
          scoreDashboard!.map((v) => v.toJson()).toList();
    }
    if (dashboard != null) {
      data['dashboard'] = dashboard!.map((v) => v.toJson()).toList();
    }
    if (lastLog != null) {
      data['last_log'] = lastLog!.map((v) => v.toJson()).toList();
    }
    if (this.bannerInfo != null) {
      data['banner_info'] = this.bannerInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ScoreDashboard {
  dynamic name;
  dynamic count;

  ScoreDashboard({this.name, this.count});

  ScoreDashboard.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    count = json['count'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = name;
    data['count'] = count;
    return data;
  }
}

class Dashboard {
  dynamic name;
  dynamic url;

  Dashboard({this.name, this.url});

  Dashboard.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    url = json['url'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name ;
    data['url'] = url;
    return data;
  }
}

class DashboardLastLog {
  dynamic lastLogType;
  dynamic lastLogTime;

  DashboardLastLog({this.lastLogType, this.lastLogTime});

  DashboardLastLog.fromJson(Map<String, dynamic> json) {
    lastLogType = json['last_log_type'] ?? '';
    lastLogTime = json['last_log_time'] ??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['last_log_type'] = lastLogType;
    data['last_log_time'] = lastLogTime;
    return data;
  }
}
class BannerInfo {
  dynamic bannerName;
  dynamic bannerImage;

  BannerInfo({this.bannerName, this.bannerImage});

  BannerInfo.fromJson(Map<String, dynamic> json) {
    bannerName = json['banner_name'];
    bannerImage = json['banner_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['banner_name'] = bannerName;
    data['banner_image'] = bannerImage;
    return data;
  }
}

