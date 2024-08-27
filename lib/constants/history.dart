import 'package:chatkid_mobile/widgets/label.dart';

class ReportStatus {
  static const String PENDING = 'PENDING';
  static const String ACCEPTED = 'ACCEPTED';
  static const String REJECTED = 'REJECTED';
  static const String NA = 'N/A';
}

final ReportStatusMap = {
  ReportStatus.PENDING: 'Đang chờ xử lý',
  ReportStatus.ACCEPTED: 'Đã chấp nhận',
  ReportStatus.REJECTED: 'Đã từ chối',
};

final ReportStatusTypeMap = {
  ReportStatus.PENDING: LabelType.INFO,
  ReportStatus.ACCEPTED: LabelType.POSITIVE,
  ReportStatus.REJECTED: LabelType.NEGATIVE,
};
