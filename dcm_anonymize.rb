require 'dicom'
include DICOM

#########

puts "Dicom anonymizer script"
puts "drag and drop or write input_dir path"
input_dir = gets.chomp.strip
puts "drag and drop or write output_dir path"
output_dir = gets.chomp.strip

# Load an anonymization instance (and specifying an audit trail file):
a = DICOM::Anonymizer.new(audit_trail: 'audit_trail.txt', delete: true)
# In addition to the default selection of tags to be anonymized, we would like to add "Manufacturer" as well:
a.set_tag('0008,0050', :value => 'AN', :enum => true)
a.set_tag('0010,0010', :value => 'Brest_MRI_', :enum => true)
a.set_tag('0010,0020', :enum => true) #PatientID
a.set_tag('0008,1030', :value => 'Brest_MRI') #StudyDescription

a.delete_tag('0008,002a') #IssueDateofImagingServiceRequest

a.remove_tag('0008,0070') #Manufacturer
a.remove_tag('0008,0080') #InstitutionName
a.remove_tag('0008,0081') #InstitutionAddress
a.remove_tag('0008,0090') #ReferringPhysiciansName
a.remove_tag('0008,1010') #StationName
a.remove_tag('0008,1040') #InstitutionalDepartmentName

a.delete_tag('0008,0070') #Manufacturer
a.delete_tag('0008,0080') #InstitutionName
a.delete_tag('0008,0081') #InstitutionAddress
a.delete_tag('0008,0090') #ReferringPhysiciansName
a.delete_tag('0008,1010') #StationName
a.delete_tag('0008,1040') #InstitutionalDepartmentName

a.delete_tag('0008,1090') #ManufacturersModelName
a.delete_tag('0008,1032') #CodeValue
a.delete_tag('0008,0102') #CodingSchemeDesignator
a.delete_tag('0008,0104') #CodeMeaning
a.delete_tag('0008,010b') #ContextGroupExtensionFlag

a.remove_tag('0010,0030') #PatientsBirthDate

a.delete_tag('0010,0032') #ProcedureCodeSequence
a.delete_tag('0010,1030') #PatientsWeight
a.delete_tag('0010,0040') #PatientsSex
a.delete_tag('0010,21c0') #PregnancyStatus
a.delete_tag('0018,1000') #DeviceSerialNumber
a.delete_tag('0032,4000') #StudyComments 
a.delete_tag('0032,1060') #RequestedProcedureDescription
a.delete_tag('0040,0241') #PerformedStationAETitle
a.delete_tag('0040,0244') #PerformedProcedureStepStartDate
a.delete_tag('0040,0250') #PerformedProcedureStepEndDate
a.delete_tag('0040,0254') #PerformedProcedureStepDescription
a.delete_tag('0040,0260') #PerformedProtocolCodeSequence
a.delete_tag('0040,0275') #RequestAttributesSequence
a.delete_tag('0040,1001') #RequestedProcedureID
a.delete_tag('0040,1400') #RequestedProcedureComments
a.delete_tag('0040,2004') #IssueDateofImagingServiceRequest
a.delete_tag('1002,105f')
a.delete_tag('2001,10c8') 
a.delete_tag('2005,1402')

#Select the enumeration feature:
a.enumeration = true
# Avoid overwriting the original files by storing the anonymized files in a separate folder from the original files:
a.write_path = output_dir
# toggles whether UIDs will be replaced with custom generated UIDs (beware that to preserve UID relations in studies/series, the audit_trail feature must be used)
a.uid = true

# Run the actual anonymization:
a.anonymize_path(input_dir)








