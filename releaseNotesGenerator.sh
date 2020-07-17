#!/bin/bash

# Script to generate release notes based on git log and Jira issues 

JIRA_TICKET_NUMBERS="jiraIds.txt"
JIRA_TEMP="jiraIdsTemp.txt"
ISSUE_DOWNLOADER_PYTHON="jiraIssueDownloader.py"

# list out the commits in the most recent merge and extract the Jira ids from the commit comments
# The commit comment should be in the following format : [<JIRA_ID>][<ISSUE_TYPE>] <Comment>

git log $(git merge-base --octopus $(git log -1 --merges --pretty=format:%P))..$(git log -1 --merges --pretty=format:%H) --pretty=oneline --abbrev-commit | grep -o "\[.*\]" | sed -re 's/(\[)(.*)(\]\[.*\])/\2/' >> $JIRA_TEMP

# The ticket numbers are sorted and then duplicate ticket numbers are removed
sort $JIRA_TEMP | uniq >> $JIRA_TICKET_NUMBERS

# Reading the ticket numbers from the file into an array
readarray -t ticket < ./$JIRA_TICKET_NUMBERS

# Printing the ticket numbers
printf '%s\n' "${ticket[@]}"

# Writing the initial HTML page
cat >> releaseNotes.html <<EOL
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<title>Release Notes</title>
		<style>
			table, th, td {
				border: 1px solid black;
			}
		</style>
	</head>
	<body>
		<h1>Release Notes</h1>
		<table style="width: 100%">
			<tr>
				<th>JIRA ID</th>
				<th>Summary</th>
				<th>Description</th>
				<th>Status</th>
				<th>Testing Type</th>
			</tr>
EOL

# Looping through the ticket numbers and calling the python script 
# The Python script calls the REST API of Jira and gets the details of the tickets / issues
for i in "${ticket[@]}"
do
		echo $i
		python $ISSUE_DOWNLOADER_PYTHON $i
done

# Completing the release notes HTML file

cat >> releaseNotes.html <<EOL

		</table>
	</body>
</html>
EOL

# removing jiraIds.txt
rm -f $JIRA_TICKET_NUMBERS
