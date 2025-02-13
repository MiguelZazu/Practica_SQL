alter table ivr_calls
  add column if not exists repeated_phone_24H integer,
  add column if not exists cause_recall_phone_24H integer;

update ivr_calls
  set
    repeated_phone_24H = (
      select case
        when start_date >= timestamp_sub(current_timestamp(), interval 24 hour) then 1
        else 0
      end
    ),
    cause_recall_phone_24H = (
      select case
        when start_date between current_timestamp() and timestamp_add(current_timestamp(), interval 24 hour) then 1
        else 0
      end
    ) where TRUE;