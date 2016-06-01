DROP TABLE IF EXISTS wordcount;
CREATE EXTERNAL TABLE wordcount (word string, count int)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
LOCATION '/user/hue/output';
DROP TABLE IF EXISTS pig_wordcount;
CREATE EXTERNAL TABLE pig_wordcount (count int, word string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
LOCATION '/user/hue/pigwordcount';