import os
import sys
import time
import psycopg2
from tqdm import tqdm

connection = psycopg2.connect(database=sys.argv[1])
cursor = connection.cursor()
cmd = "insert into oban_jobs (state,queue,worker,args) values (%s,%s,%s,%s)"
with open("jobs.backup", "r") as f, open("/tmp/failed.backup", "w") as g:
    for i in tqdm(f):
        data = [x.strip() for x in i.split("|")]
        try:
            cursor.execute(cmd, ("available", data[2], data[3], data[4]))
            connection.commit()
        except Exception as ex:
            print(ex)
            g.write(i)
        time.sleep(0.2)
