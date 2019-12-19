#!/bin/bash

set -euo pipefail

pipenv install

if [ $# -lt 1 ]; then
	echo "Usage: ./run.sh db_name"
	exit 1
fi

DB="$1"

read -p "Are you on a durable terminal (tmux/screen)? This will take a LONG time!!! (y/n) " OK

if [ "$OK" != "y" ]; then
	echo "exiting"
	exit 1
fi

echo "Dumping queue to file..."

psql $DB -tc "select * from oban_jobs where queue='federator_outgoing' and state in ('retryable', 'available')" > jobs.backup

echo "Dumped."

echo "Draining queue..."
psql $DB -tc "delete from oban_jobs"
echo "Drained"
echo "Expecting $(wc -l jobs.backup) entries."
echo "Respooling..."
sudo -Hu pleroma pipenv run python insert.py "$DB"
echo "Have a nice day!"
