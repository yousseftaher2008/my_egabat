const num hourPrice = 0;

class Employee {
  //...
  List<Days> daysList = [];
  //...
}

class Days {
  //.....
  Period firstLastFingerprint = const Period(10, 18);
  List<Period> dayFingerprints = [
    const Period(10, 11),
    const Period(11.25, 13),
    const Period(13.5, 13.75),
    const Period(16, 17.25),
    const Period(17.50, 18),
  ];
  final bool isAbsent = false;
  final bool isVacation = false;
  final num permissionTime = 0.15;

  num daySalary() {
    //.....
    num salary = 0;
    num dayWorkedTime = 0;
    for (final Period period in dayFingerprints) {
      dayWorkedTime += period.workedTime();
    }

    if (dayWorkedTime > 8) {
      // Todo
    } else if (dayWorkedTime < 8) {
      // Todo
    }
    salary += dayWorkedTime;
    salary += (permissionTime * hourPrice);
    return salary;
    //.....
  }
  //.....
}

class Period {
  //.....
  final num attendance;
  final num absence;

  const Period(this.attendance, this.absence);

  num workedTime() {
    //.....
    return attendance - absence;
    //.....
  }
  //.....
}
