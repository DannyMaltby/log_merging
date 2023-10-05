# log_merging
Powershell scripts for merging log files (txt &amp; csv) and removing redundant/duplicate entries.

Use cases:
  txt log merge:
    For instances where you get a common log file format across multipe areas. This particular script was created to collate success/failure logs each day after automated account creation/modification was run in multiple different locations.

  csv content merge:
    For instances where you want to continually merge content from identically formatted csv files. This script was created to merge account details whenever accounts are created by an automated service, the service adds entries to site specific csv files whenever new accounts are generated. The script creates a master csv that continually checks for new entries and adds them to the output csv.
