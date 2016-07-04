.mode column
.head on

#Created by Zhao Jie and Shuopeng Wu

PRAGMA writable_schema = 1;
delete from sqlite_master where type = 'table' and name not like "anns";
PRAGMA writable_schema = 0;
------------GET RRs---------------
CREATE TABLE MyRRs AS
	SELECT lead, sample FROM anns WHERE feature = "R";

CREATE TABLE RRI AS
	SELECT sample1.lead, sample1.sample, sample2.sample - sample1.sample AS TimeDiff
		FROM MyRRs sample1, MyRRs sample2
		WHERE (sample1.rowid = sample2.rowid - 1 AND sample1.lead = sample2.lead) ORDER BY sample1.sample;

ALTER TABLE RRI ADD COLUMN HeartRate numeric;
UPDATE RRI SET HeartRate = 12000/TimeDiff;

ALTER TABLE RRI ADD COLUMN feature;
UPDATE RRI SET feature = "R";

-------------GET QTs---------------
CREATE TABLE MyQTs AS
	SELECT lead,sample,feature FROM anns WHERE feature = "N" OR feature = "t)";

CREATE TABLE QT AS
 	SELECT sample1.lead,sample1.sample,sample2.sample - sample1.sample AS QtDiff 
 	FROM myqts sample1, myqts sample2
 	WHERE (sample1.rowid = sample2.rowid -1 AND sample1.lead = sample2.lead AND sample1.feature = "N" AND sample2.feature = "t)") 
 	ORDER BY sample1.sample;

ALTER TABLE QT ADD COLUMN qti_ms numeric;
UPDATE QT SET qti_ms = qtdiff*5;

ALTER TABLE QT ADD COLUMN feature;
UPDATE QT SET feature = "QT";

--------UNION QT WITH RR-----------
CREATE TABLE uu AS
	SELECT * FROM RRI
	UNION
	SELECT * FROM QT
	ORDER BY lead,sample;
--------CLEAN RRQT-----------
CREATE TABLE rrqt AS
	SELECT sample1.lead, sample1.sample AS qstart, sample1.heartrate AS qti, sample2.heartrate AS heartrate, sample2.timediff/200.0 AS rri
	FROM uu sample1, uu sample2
	WHERE (sample1.rowid = sample2.rowid - 1 AND sample1.feature = "QT" AND sample2.feature = "R" AND sample1.lead = sample2.lead)
 	ORDER BY qstart,sample1.lead;
--------ADD RELATIVE TIME-----------
ALTER TABLE rrqt ADD COLUMN Hour text;
UPDATE rrqt SET Hour = substr('0'||cast(qstart/(200*60*60) as text), -2);

ALTER TABLE rrqt ADD COLUMN Min text;
UPDATE rrqt SET Min = substr('0'||cast((qstart - (200*60*60) * Hour)/ (200 * 60) as text), -2);

ALTER TABLE rrqt ADD COLUMN Sec text;
UPDATE rrqt SET Sec = substr('0'||cast((qstart - (200*60) * (qstart/(200*60)))/200 as text),-2);

ALTER TABLE rrqt ADD COLUMN Ms text;
UPDATE rrqt SET Ms = substr(cast((qstart - (200 * (qstart/200)))/200.0 as text)||'000',3,3);

ALTER TABLE rrqt ADD COLUMN Time;
UPDATE rrqt SET Time = Hour||':'||Min||':'||Sec||'.'||Ms;
--------GET FORMED RRQT TABLE---------------
CREATE TABLE MyRRQT AS
	SELECT lead, Time, HeartRate, qti, rri FROM rrqt;

.mode csv
.output rrqt.csv 
SELECT * FROM MyRRQT;
.output stdout
