class FamilyApiResult {
  final bool success;
  final String message;
  final Map<String, dynamic>? group;
  final Map<String, dynamic>? invite;
  final String? groupName;
  final List<Map<String, dynamic>>? members;
  final String? error;
  final String? inviteCode;

  FamilyApiResult({
    required this.success,
    required this.message,
    this.group,
    this.invite,
    this.groupName,
    this.members,
    this.inviteCode,
    this.error,
  });

  factory FamilyApiResult.fromJson(Map<String, dynamic> json, int statusCode) {
    bool isSuccess = statusCode >= 200 && statusCode < 300;
    List<Map<String, dynamic>>? membersList;
    if (json['members'] != null && json['members'] is List) {
      membersList =
          (json['members'] as List)
              .map((e) => Map<String, dynamic>.from(e as Map))
              .toList();
    }
    return FamilyApiResult(
      success: isSuccess,
      message: json['message'] ?? (isSuccess ? 'Success' : 'Failed'),
      group: json['group'] as Map<String, dynamic>?,
      invite: json['invite'] as Map<String, dynamic>?,
      groupName: json['groupName'] as String?,
      members: membersList,
      inviteCode: json['invite_code'] as String?,
      error: json['error'] as String?,
    );
  }
}
