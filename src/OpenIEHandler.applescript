on open location theURL
	set cleanURL to theURL as text
	
	-- Strip openIE: or openie: protocol scheme
	if cleanURL starts with "openIE:" then
		set cleanURL to text 8 thru -1 of cleanURL
	else if cleanURL starts with "openie:" then
		set cleanURL to text 8 thru -1 of cleanURL
	end if
	
	-- Strip leading slashes if passed as openIE://http...
	if cleanURL starts with "//http:" then
		set cleanURL to text 3 thru -1 of cleanURL
	else if cleanURL starts with "//https:" then
		set cleanURL to text 3 thru -1 of cleanURL
	end if
	
	-- Replace 'separator' parameter delimiter with '&'
	set oldDelims to AppleScript's text item delimiters
	set AppleScript's text item delimiters to "separator"
	set urlParts to text items of cleanURL
	set AppleScript's text item delimiters to "&"
	set finalURL to urlParts as text
	set AppleScript's text item delimiters to oldDelims
	
	-- Open the decoded target URL in macOS default browser
	do shell script "open " & quoted form of finalURL
end open location
