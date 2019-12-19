# pleroma-oban-respooler

Dump all jobs from your oban queue and slowly re-queue them
slowly

Meant for use when your oban queue gets overwhelmed and nothing
is federating

You will need:
- pipenv

Usage:

`./run.sh pleroma_db_name pleroma_user`

for example, `./run.sh pleroma_dev pleroma`
