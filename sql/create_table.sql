DROP TABLE IF EXISTS vehicle_latitude;

CREATE TABLE vehicle_latitude (
    ID VARCHAR(25) NOT NULL,
    vendorId INT NOT NULL,
    pickupDate DATE NOT NULL,
    dropoffDate DATE NOT NULL,
    passengerCount INT NOT NULL,
    pickupLongitude NUMERIC(10,8) NOT NULL,
    pickupLatitude NUMERIC(10,8) NOT NULL,
    dropoffLongitude NUMERIC(10,8) NOT NULL,
    dropoffLatitude NUMERIC(10,8)NOT NULL,
    storeAndFwdFlag CHAR(1) NOT NULL,
    gcDistance INT NOT NULL,
    tripDuration TIMESTAMP NOT NULL,
    googleDistance INT NOT NULL,
    googleDuration TIMESTAMP NOT NULL
);

--- external schema for kinesis ---
CREATE EXTERNAL SCHEMA streamdataschema
FROM KINESIS
IAM_ROLE 'arn:aws:iam::533267024701:role/redshiftkinesisrole';

---- create materialized view ----

CREATE MATERIALIZED VIEW devicedataview AS
    SELECT approximate_arrival_timestamp,
    partition_key,
    shard_id,
    sequence_number,
    json_parse(from_varbyte(kinesis_data, 'utf-8')) as payload    
    FROM streamdataschema."d2d-app-kinesis-stream";
	
---- refresh view ----

REFRESH MATERIALIZED VIEW <VIEW_NAME>;

--- select data from view ----

select * from <VIEW_NAME>

---- JSON PARSER ----

    googleDistance INT NOT NULL,
    googleDuration TIMESTAMP NOT NULL





CREATE MATERIALIZED VIEW vehicle_streamdataschema DISTKEY(6) sortkey(1) AUTO REFRESH YES AS
    SELECT
     refresh_time,
    approximate_arrival_timestamp,
    partition_key,
    shard_id,
    sequence_number,
    json_extract_path_text(from_varbyte(kinesis_data,'utf-8'),'id',true)::character(36) as ID,
    json_extract_path_text(from_varbyte(kinesis_data,'utf-8'),'vendorId',true)::INT as vendorId,
    json_extract_path_text(from_varbyte(kinesis_data,'utf-8'),'pickupDate',true)::character(25) as pickupDate,
    json_extract_path_text(from_varbyte(kinesis_data,'utf-8'),'dropoffDate',true)::character(25)as dropoffDate,
    json_extract_path_text(from_varbyte(kinesis_data,'utf-8'),'passengerCount',true)::INT as passengerCount,
    json_extract_path_text(from_varbyte(kinesis_data,'utf-8'),'pickupLongitude',true)::NUMERIC(10,8) as pickupLongitude,
    json_extract_path_text(from_varbyte(kinesis_data,'utf-8'),'pickupLatitude',true)::NUMERIC(10,8)as pickupLatitude,
    json_extract_path_text(from_varbyte(kinesis_data,'utf-8'),'dropoffLongitude',true)::NUMERIC(10,8) as dropoffLongitude,
    json_extract_path_text(from_varbyte(kinesis_data,'utf-8'),'dropoffLatitude',true)::NUMERIC(10,8) as dropoffLatitude,
    json_extract_path_text(from_varbyte(kinesis_data,'utf-8'),'storeAndFwdFlag',true)::CHAR(1) as storeAndFwdFlag,
    json_extract_path_text(from_varbyte(kinesis_data,'utf-8'),'gcDistance',true)::INT as gcDistance,
    json_extract_path_text(from_varbyte(kinesis_data,'utf-8'),'tripDuration',true)::character(25) as tripDuration,
    json_extract_path_text(from_varbyte(kinesis_data,'utf-8'),'googleDistance',true)::INT as googleDistance,
    json_extract_path_text(from_varbyte(kinesis_data,'utf-8'),'googleDuration ',true)::DECIMAL(10,2) as googleDuration 
    FROM streamdataschema."d2d-app-kinesis-stream"
    -- WHERE LENGTH(kinesis_data) < 65355
    ;