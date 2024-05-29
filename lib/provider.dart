import 'package:flutter/material.dart';



class PointsProvider with ChangeNotifier {
  int _totalRewardPoints = 0;
  bool _isChallengeCompleted = false;

  int get totalRewardPoints => _totalRewardPoints;
  bool get isChallengeCompleted => _isChallengeCompleted;

  void updateRewardPoints(int points) {
    _totalRewardPoints += points;
    notifyListeners();
  }

  void toggleChallengeCompletion() {
    _isChallengeCompleted = !_isChallengeCompleted;
    if (_isChallengeCompleted) {
      _totalRewardPoints += 10;
    } else {
      _totalRewardPoints -= 10;
    }
    notifyListeners();
  }
   int _rewardPoints = 0;

  int get rewardPoints => _rewardPoints;
  

  void setRewardPoints(int points) {
    _rewardPoints = points;
    notifyListeners();
  }
}
