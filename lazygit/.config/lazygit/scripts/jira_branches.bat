@echo off
curl.exe -s -H ^
  "Authorization: Bearer %JR_CLI_AT%" ^
  "%JR_CLI_HOST%/rest/api/2/search?jql=assignee+in+(currentUser())+and+resolution+is+empty&fields=summary" ^
  | jq ".issues | map ({key, \"summary\": .fields.summary})" ^
  | jq -r ".[] | [.key, \"AtH\", .summary] | join(\"_\") | gsub(\"[\\s()']\"; \"_\")"

