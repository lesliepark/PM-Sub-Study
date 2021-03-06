//
//  ConsentDocument.swift
//  PM Sub Study
//
//  Created by Travis Allen on 12/12/18.
//  Copyright © 2018 Travis Allen. All rights reserved.
//
import Foundation
import ResearchKit

public var ConsentDocument: ORKConsentDocument {
    
    let consentDocument = ORKConsentDocument()
    consentDocument.title = "Consent for 'Research for Precision Medicine – Exploring Retrospective and Prospective Patient-Generated Data in Precision Medicine Sub Study'"
    
    //    let consentSectionTypes: [ORKConsentSectionType] = [
    //        .overview,
    //        .dataGathering,
    //        .privacy,
    //        .dataUse,
    //        .timeCommitment,
    //        .studySurvey,
    //        .studyTasks,
    //        .withdrawing
    //    ]
    
    var consentSections = [ORKConsentSection]()
    
    let introSection = ORKConsentSection(type: .overview)
    introSection.summary = "You are invited to consider participating in a research study"
    introSection.content = "You are invited to consider participating in a research study. The study is called 'Research for Precision Medicine.' This form contains information about the study, which includes the purpose of the study, what participation involves, possible benefits, risks and discomforts, other options, your rights as a participant, and other information about the study. This form is also used to obtain your written consent to be part of the study and your written authorization for the use and disclosure of medical information that will be obtained from you in the course of the study. \nPlease read this form carefully and take your time to make your decision. You will have an opportunity to ask questions and discuss anything that you do not understand with your doctor. The decision to participate or not to participate is yours. It is important that you read and understand several general principles that apply to all who take part in our studies:\n\n(a)Taking part in the study is entirely voluntary.\n\n(b)Personal benefit to you may or may not result from taking part in the study, but knowledge gained from your participation may benefit others.\n\n(c)You may decide not to participate in the study or you may decide to stop participating in the study at any time without loss of any benefits to which you are entitled."
    
    consentSections += [introSection]
    let dataSection = ORKConsentSection(type: .dataGathering)
    dataSection.summary = ""
    dataSection.htmlContent = "If you agree to participate in this sub study, we will collect health information as described below:<br><b>Prospective Data</b><br>For the prospective study component, established mobile research applications, built using ResearchKit™ and ResearchStack, will be deployed to prospectively capture fine-grained active and passive reporting of day-to-day treatment side effects and performance status. These patient-generated data will be compared with your clinical records and follow-up data to assess the feasibility of reliably and meaningfully extracting patient state.<br>Prospective data will include PROs and patient-generated data and will be collected using a mobile application. You will be regularly prompted to take standardized surveys to track changes to your therapy or treating physician, report any hospitalizations, assess your Quality of Life, and provide updates on co-morbidities and family history. You will also use visual reporting tools to report on your daily affect and activities of daily living. The app will utilize location services data to identify when you leave and arrive at home and at ‘work’ (or a second key location) to estimate time out of the house, time at work, time sedentary, and overall daily activity. Using a visual interface, you will be asked to identify any side-effects you experienced on a daily basis and to report on your physical, social, emotional, and functional well-being on a weekly basis."
    consentSections += [dataSection]
    
    let privacySection = ORKConsentSection(type: .privacy)
    privacySection.summary = "Efforts will be made to protect your privacy in this study"
    
    privacySection.content = "Efforts will be made to protect your medical records and other personal information to the extent allowed by law. However, we cannot guarantee absolute confidentiality. Medical records of research study participants are stored and kept according to legal requirements. You will not be identified personally in any reports or publications resulting from this study. Organizations that may request to inspect and/or copy your research and medical records for quality assurance and data analysis include groups such as:\n\n (1)Precision Medicine Tumor Board\n (2)Institutional Review Board (IRB)\n(3)Department of Health and Human Services and National Institutes of Health\n(4)All appropriate Federal oversight agencies\n\nThis research study may be performed only by collecting and using your health information, described above. The information collected may identify you by name, address, telephone number, social security number, health plan number, study number, date of birth, e-mail address, internet protocol (IP) address, device ID, dates relating to various medical procedures, or other identifying information.\n\nIf information about your participation in this study is stored in a computer, we will take the following precautions to protect it from unauthorized disclosure, tampering, or damage: All computers will be maintained in locked rooms, cabinets, or drawers and passwords will be required for access to these computers. Only study investigators and research personnel will have access to this data.\n\n Data will be stored in a manner that maintains strict information technology procedures to safeguard participant information and to prevent improper access. The server application used for storing and managing study data will be securely hosted and managed by the Clinical & Translational Science Center (CTSC) at Weill Cornell Medicine. Additionally, all data and extracted features stay in Google infrastructure to reduce the risk of data exposure.\n\n In an effort to maintain confidentiality, your study records, if sent outside the hospital, will be identified only by a number and initials. You will not be personally identified in any reports or publications that may result from this research study. Because of the research goals of this study, however, your study records cannot be kept absolutely confidential.\n\nYour access to your underlying medical records will not be affected by the study. You have the right to see and copy the medical information collected from you in the course of the study for as long as that information is maintained by the study personnel and other entities subject to federal privacy regulation.\n\nThis authorization has no expiration date. In signing this form, you authorize the use and disclosure of your information for purposes of the study at any time in the future."
    consentSections += [privacySection]
    
    let durationSection = ORKConsentSection(type: .timeCommitment)
    durationSection.summary = "The duration of this study is indefinite."
    durationSection.content = "Study participation is indefinite. This involves periodically updating our database through retrieval of your electronic medical records and other clinical records at regular intervals, as part of the primary “Research for Precision Medicine” study. The stored prospective and retrospective data will also be retained for analysis until the study is over. However, you can stop participating at any time by revoking the access to your Google Drive and deleting the data from our database using our web app. If you decide to stop participating in the study, we encourage you to talk to the researcher and your regular doctor first."
    consentSections += [durationSection]
    
    let withdrawalSection = ORKConsentSection(type: .withdrawing)
    withdrawalSection.htmlContent = "<b><u>CANCELING AUTHORIZATION</b></u><br>If you give the WCMC and/or NYPH researchers permission to use or share your protected health information, you have the right to cancel your permission whenever you want. However, canceling your permission will not apply to information that the researchers have already used or shared.<br>If you wish to cancel your permission, you may do so at any time by writing to:<br>Privacy Officer<br>1300 York Avenue, Box 303<br>New York, NY 10065<br>If you have questions about this, call: (646) 962-6930 or e-mail: privacy@med.cornell.edu<br>End of Permission: Unless you cancel it, permission for WCMC and/or NYPH researchers to use or share your protected health information for their research will never end.<br><br><b><u>WITHDRAWAL BY INVESTIGATOR</b></u><br>The investigators or physicians may stop the study or take you out of the study at any time should they judge that it is in your best interest to do so, if you experience a serious injury, or if you do not comply with the study plan. They may remove you from the study for various other administrative and medical reasons. They can do this without your consent. If you withdraw from this study or if you are withdrawn from the study, any data already collected will continue to be used. However, no new data will be collected."
    consentDocument.sections = consentSections
    
    consentDocument.addSignature(ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "ConsentDocumentParticipantSignature"))
    
    return consentDocument
}
