class Loan {
  final String id;
  final String user;
  final String uhid;
  final String applicationNumber;
  final int currentStep;
  final PersonalInfo personalInfo;
  final EmploymentInfo employmentInfo;
  final MedicalInfo medicalInfo;
  final LoanDetails loanDetails;
  final Documents documents;
  final String kycStatus;
  final String status;
  final bool? agreementSigned;
  final bool? nachMandateSigned;
  final bool? termsAccepted;
  final DateTime applicationDate;
  final List<EmiPayment> emiPayments;
  final String? submissionDate;
  final String? transactionId;
  final String? rejectionReason;
  final String? approvalDate;
  final double? monthlyPayment;
  final double? remainingBalance;
  final String? nextEmiDate;
  final int? creditScore;
  final int? v;

  Loan({
    required this.id,
    required this.user,
    required this.uhid,
    required this.applicationNumber,
    required this.currentStep,
    required this.personalInfo,
    required this.employmentInfo,
    required this.medicalInfo,
    required this.loanDetails,
    required this.documents,
    required this.kycStatus,
    required this.status,
    this.agreementSigned,
    this.nachMandateSigned,
    this.termsAccepted,
    required this.applicationDate,
    required this.emiPayments,
    this.submissionDate,
    this.transactionId,
    this.rejectionReason,
    this.approvalDate,
    this.monthlyPayment,
    this.remainingBalance,
    this.nextEmiDate,
    this.creditScore,
    this.v,
  });

  factory Loan.fromJson(Map<String, dynamic> json) {
    return Loan(
      id: json['_id'] ?? '',
      user: json['user'] ?? '',
      uhid: json['uhid'] ?? '',
      applicationNumber: json['applicationNumber'] ?? '',
      currentStep: json['currentStep'] ?? 0,
      personalInfo: PersonalInfo.fromJson(json['personalInfo'] ?? {}),
      employmentInfo: EmploymentInfo.fromJson(json['employmentInfo'] ?? {}),
      medicalInfo: MedicalInfo.fromJson(json['medicalInfo'] ?? {}),
      loanDetails: LoanDetails.fromJson(json['loanDetails'] ?? {}),
      documents: Documents.fromJson(json['documents'] ?? {}),
      kycStatus: json['kycStatus'] ?? '',
      status: json['status'] ?? '',
      agreementSigned: json['agreementSigned'],
      nachMandateSigned: json['nachMandateSigned'],
      termsAccepted: json['termsAccepted'],
      applicationDate: DateTime.parse(json['applicationDate'] ?? DateTime.now().toIso8601String()),
      emiPayments: (json['emiPayments'] as List? ?? []).map((e) => EmiPayment.fromJson(e)).toList(),
      submissionDate: json['submissionDate'],
      transactionId: json['transactionId'],
      rejectionReason: json['rejectionReason'],
      approvalDate: json['approvalDate'],
      monthlyPayment: (json['monthlyPayment'] ?? 0).toDouble(),
      remainingBalance: (json['remainingBalance'] ?? 0).toDouble(),
      nextEmiDate: json['nextEmiDate'],
      creditScore: json['creditScore'],
      v: json['__v'],
    );
  }
}

class PersonalInfo {
  final String fullName;
  final String? dateOfBirth;
  final String? gender;
  final String? phoneNumber;
  final String? secondaryPhone;
  final String? email;
  final String? homeAddress;
  final String? city;
  final String? state;
  final String? zipCode;
  final String? nationalId;
  final String? maritalStatus;
  final String? dependents;
  final String? citizenshipStatus;
  final String? languagePreference;

  PersonalInfo({
    required this.fullName,
    this.dateOfBirth,
    this.gender,
    this.phoneNumber,
    this.secondaryPhone,
    this.email,
    this.homeAddress,
    this.city,
    this.state,
    this.zipCode,
    this.nationalId,
    this.maritalStatus,
    this.dependents,
    this.citizenshipStatus,
    this.languagePreference,
  });

  factory PersonalInfo.fromJson(Map<String, dynamic> json) {
    return PersonalInfo(
      fullName: json['fullName'] ?? '',
      dateOfBirth: json['dateOfBirth'],
      gender: json['gender'],
      phoneNumber: json['phoneNumber'],
      secondaryPhone: json['secondaryPhone'],
      email: json['email'],
      homeAddress: json['homeAddress'],
      city: json['city'],
      state: json['state'],
      zipCode: json['zipCode'],
      nationalId: json['nationalId'],
      maritalStatus: json['maritalStatus'],
      dependents: json['dependents'],
      citizenshipStatus: json['citizenshipStatus'],
      languagePreference: json['languagePreference'],
    );
  }
}

class EmploymentInfo {
  final String? employerName;
  final String? employerAddress;
  final String? occupation;
  final String? employmentStatus;
  final String? startDate;
  final double? monthlyGrossIncome;
  final String? additionalIncome;
  final bool? unemploymentBenefits;
  final double? totalHouseholdIncome;
  final String? householdMembersInfo;
  final String? incomeFluctuation;

  EmploymentInfo({
    this.employerName,
    this.employerAddress,
    this.occupation,
    this.employmentStatus,
    this.startDate,
    this.monthlyGrossIncome,
    this.additionalIncome,
    this.unemploymentBenefits,
    this.totalHouseholdIncome,
    this.householdMembersInfo,
    this.incomeFluctuation,
  });

  factory EmploymentInfo.fromJson(Map<String, dynamic> json) {
    return EmploymentInfo(
      employerName: json['employerName'],
      employerAddress: json['employerAddress'],
      occupation: json['occupation'],
      employmentStatus: json['employmentStatus'],
      startDate: json['startDate'],
      monthlyGrossIncome: (json['monthlyGrossIncome'] ?? 0).toDouble(),
      additionalIncome: json['additionalIncome'],
      unemploymentBenefits: json['unemploymentBenefits'],
      totalHouseholdIncome: (json['totalHouseholdIncome'] ?? 0).toDouble(),
      householdMembersInfo: json['householdMembersInfo'],
      incomeFluctuation: json['incomeFluctuation'],
    );
  }
}

class MedicalInfo {
  final String? treatmentRequired;
  final String? medicalProvider;
  final bool? treatmentStarted;
  final double? estimatedCost;
  final double? insuranceCoverage;
  final String? insuranceProvider;
  final String? policyNumber;
  final bool? healthPlanCovered;
  final bool? appliedFinancialAssistance;
  final String? preExistingConditions;
  final String? outstandingMedicalDebt;

  MedicalInfo({
    this.treatmentRequired,
    this.medicalProvider,
    this.treatmentStarted,
    this.estimatedCost,
    this.insuranceCoverage,
    this.insuranceProvider,
    this.policyNumber,
    this.healthPlanCovered,
    this.appliedFinancialAssistance,
    this.preExistingConditions,
    this.outstandingMedicalDebt,
  });

  factory MedicalInfo.fromJson(Map<String, dynamic> json) {
    return MedicalInfo(
      treatmentRequired: json['treatmentRequired'],
      medicalProvider: json['medicalProvider'],
      treatmentStarted: json['treatmentStarted'],
      estimatedCost: (json['estimatedCost'] ?? 0).toDouble(),
      insuranceCoverage: (json['insuranceCoverage'] ?? 0).toDouble(),
      insuranceProvider: json['insuranceProvider'],
      policyNumber: json['policyNumber'],
      healthPlanCovered: json['healthPlanCovered'],
      appliedFinancialAssistance: json['appliedFinancialAssistance'],
      preExistingConditions: json['preExistingConditions'],
      outstandingMedicalDebt: json['outstandingMedicalDebt'],
    );
  }
}

class LoanDetails {
  final double? requestedAmount;
  final int? preferredTerm;
  final String? repaymentMethod;
  final double? approvedAmount;
  final double? interestRate;

  LoanDetails({
    this.requestedAmount,
    this.preferredTerm,
    this.repaymentMethod,
    this.approvedAmount,
    this.interestRate,
  });

  factory LoanDetails.fromJson(Map<String, dynamic> json) {
    return LoanDetails(
      requestedAmount: (json['requestedAmount'] ?? 0).toDouble(),
      preferredTerm: json['preferredTerm'],
      repaymentMethod: json['repaymentMethod'],
      approvedAmount: (json['approvedAmount'] ?? 0).toDouble(),
      interestRate: (json['interestRate'] ?? 0).toDouble(),
    );
  }
}

class Documents {
  final String? panCard;
  final String? aadhaarCard;
  final String? incomeProof;
  final String? bankStatement;
  final String? medicalDocuments;

  Documents({
    this.panCard,
    this.aadhaarCard,
    this.incomeProof,
    this.bankStatement,
    this.medicalDocuments,
  });

  factory Documents.fromJson(Map<String, dynamic> json) {
    return Documents(
      panCard: json['panCard'],
      aadhaarCard: json['aadhaarCard'],
      incomeProof: json['incomeProof'],
      bankStatement: json['bankStatement'],
      medicalDocuments: json['medicalDocuments'],
    );
  }
}

class EmiPayment {
  final String? paymentDate;
  final double? amount;
  final double? principalAmount;
  final double? interestAmount;
  final String? transactionId;
  final String? paymentMethod;
  final String? status;
  final String? id;

  EmiPayment({
    this.paymentDate,
    this.amount,
    this.principalAmount,
    this.interestAmount,
    this.transactionId,
    this.paymentMethod,
    this.status,
    this.id,
  });

  factory EmiPayment.fromJson(Map<String, dynamic> json) {
    return EmiPayment(
      paymentDate: json['paymentDate'],
      amount: (json['amount'] ?? 0).toDouble(),
      principalAmount: (json['principalAmount'] ?? 0).toDouble(),
      interestAmount: (json['interestAmount'] ?? 0).toDouble(),
      transactionId: json['transactionId'],
      paymentMethod: json['paymentMethod'],
      status: json['status'],
      id: json['_id'],
    );
  }
}