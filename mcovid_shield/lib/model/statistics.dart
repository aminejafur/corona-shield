import 'dart:convert';

class Statistics {
  final int confirmed;
  final int todayConfirmed;
  final int recovered;
  final int todayRecovered;
  final int deaths;
  final int todayDeaths;
  final bool casesIcon;
  final bool recoversIcon;
  final bool deathsIcon;
  final int tests;

  Statistics({this.confirmed, this.recovered, this.deaths, this.todayConfirmed, this.todayRecovered, this.todayDeaths, this.casesIcon, this.recoversIcon, this.deathsIcon, this.tests});

  factory Statistics.fromJson(Map<String, dynamic> json) {
    return Statistics(
      confirmed: json['cases'],
      recovered: json['recovered'],
      deaths: json['deaths'],
      //get today data using todays and yesterday cases!
      todayConfirmed: json['todayCases'],
      todayRecovered: json['TodayRecovers'],
      todayDeaths: json['todayDeaths'],
      //get icons data
      casesIcon: json['casesIcon'],
      recoversIcon: json['recoversIcon'],
      deathsIcon: json['deathsIcon'],
      //Tests
      tests: json['tests'],
    );
  }
}