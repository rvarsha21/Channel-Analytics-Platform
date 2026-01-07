----- Build a Cortex Search service to search on the descriptive column
----- in the bronze layer and try few searches.
USE DATABASE DB_TEAM_VRR;
USE SCHEMA BRONZE;
select * from DB_TEAM_VRR.BRONZE.YOUTUBE_CHANNELS_RAW limit 5;
DESC TABLE DB_TEAM_VRR.BRONZE.YOUTUBE_CHANNELS_RAW;
select "channel_id" from YOUTUBE_CHANNELS_RAW
CREATE OR REPLACE VIEW YT_CHANNELS_SEARCH_SRC AS
SELECT
  "channel_id"    AS CHANNEL_ID,
  "channel_name"  AS CHANNEL_NAME,
  "category"      AS CATEGORY,
  "country"       AS COUNTRY,
  "description"   AS DESCRIPTION
FROM DB_TEAM_VRR.BRONZE.YOUTUBE_CHANNELS_RAW
WHERE "description" IS NOT NULL;
CREATE OR REPLACE CORTEX SEARCH SERVICE YT_CHANNEL_SEARCH
  ON (DESCRIPTION)
  WAREHOUSE = ANIMAL_TASK_WH
  TARGET_LAG = '1 hour'
  AS (
    SELECT
      CHANNEL_ID,
      CHANNEL_NAME,
      CATEGORY,
      COUNTRY,
      DESCRIPTION
    FROM DB_TEAM_VRR.BRONZE.YT_CHANNELS_SEARCH_SRC
  );
-- 1) K-pop / Korean music channels
SELECT SNOWFLAKE.CORTEX.SEARCH_PREVIEW(
  'YT_CHANNEL_SEARCH',
  '{
    "query": "K-pop or Korean pop music channel",
    "limit": 5
  }'
);
-- 2) Indian entertainment / film content
SELECT SNOWFLAKE.CORTEX.SEARCH_PREVIEW(
  'YT_CHANNEL_SEARCH',
  '{
    "query": "Indian entertainment and film content",
    "limit": 5
  }'
);
-- 3) Gaming / action-adventure channels
SELECT SNOWFLAKE.CORTEX.SEARCH_PREVIEW(
  'YT_CHANNEL_SEARCH',
  '{
    "query": "gaming channel with action and role-playing games",
    "limit": 5
  }'
);