class CustomFunction {
  static String getTimeShift(int index) {
    switch (index) {
      case 1:
        return '7-12';
      case 2:
        return '13-19';
      case 3:
        return '21-2';
      default:
        return '';
    }
  }

  static Map<String, dynamic> getDateToday() {
    final start = DateTime.utc(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    final end = DateTime.utc(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      24,
    );

    return {
      'start': start,
      'end': end,
    };
  }

  static String getSchedType(int index) {
    switch (index) {
      case 0:
        return 'Scheduled';
      case 1:
        return 'ASAP';
      default:
        return 'INVALID';
    }
  }

  static String getStatus(int index) {
    switch (index) {
      case 0:
        return 'STAND BY';
      case 1:
        return 'ON THE WAY(PICK UP)';
      case 2:
        return 'ON THE WAY(TO HUB)';
      case 3:
        return 'RECEIVED BY THE HUB ON QUEUE';
      case 4:
        return 'WASH IN PROGRESS';
      case 5:
        return 'READY TO DELIVER';
      case 6:
        return 'IN TRANSIT';
      case 7:
        return 'DELIVERED';
      default:
        return '';
    }
  }
}
