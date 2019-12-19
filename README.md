# pleroma-oban-respooler

Dump all jobs from your oban queue and slowly re-queue them
slowly

Meant for use when your oban queue gets overwhelmed and nothing
is federating

You will need:
- pipenv

the script assumes your pleroma user is called `pleroma`

Usage:

`./run.sh pleroma_dev`
