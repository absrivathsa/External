from jira import JIRA
import sys

options = {'server': 'https://absrivathsa.atlassian.net/','verify':False, 'basic_auth':('absrivathsa@deloitte.com','YQeAsuoJFQ8RfK7PVHDK8247')}
jira = JIRA(options)


#issue = jira.issue(sys.argv[1])

#summary = issue.fields.summary
#description = issue.fields.description
#status = issue.fields.status
#testing_type = issue.fields.testing.type

jira_id = sys.argv[1]
summary = "This is a summary"
description = "This is a description \n and it is multiple lines"
status = "In Progress"
testing_type = "SIT"



file_object = open('releaseNotes.html','a')
file_object.write('\n\t\t\t<tr>')
file_object.write('\n\t\t\t\t<td>'+ jira_id + '</td>')
file_object.write('\n\t\t\t\t<td>'+ summary + '</td>')
file_object.write('\n\t\t\t\t<td>'+ description + '</td>')
file_object.write('\n\t\t\t\t<td>'+ status + '</td>')
file_object.write('\n\t\t\t\t<td>'+ testing_type + '</td>')
file_object.write('\n\t\t\t</tr>')
file_object.close()

#print(issue.fields.project.key)            # 'JRA'
#print(issue.fields.issuetype.name)         # 'New Feature'
#print(issue.fields.reporter.displayName)   # 'Mike Cannon-Brookes [Atlassian]'
