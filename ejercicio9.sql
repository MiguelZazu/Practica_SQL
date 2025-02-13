alter table ivr_calls
  add column if not exists info_by_phone_lg integer;

update ivr_calls as c
  set c.info_by_phone_lg = (
    select max(case 
      when step_name = 'CUSTOMERINFOBYPHONE.TX' and step_result = 'OK' then 1
      else 0
    end)
    from ivr_steps as s
    where c.ivr_id = s.ivr_id
  )
  where exists (
    select 1 from ivr_steps as s where c.ivr_id = s.ivr_id
  );