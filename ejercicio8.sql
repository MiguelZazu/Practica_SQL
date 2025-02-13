alter table ivr_calls
  add column if not exists masiva_lg integer;

update ivr_calls as c
  set c.masiva_lg = (
    select case 
      when array_agg(m.module_name order by m.module_name limit 1)[offset(0)] = 'AVERIA_MASIVA' then 1
      else 0
    end
    from ivr_modules as m
    where c.ivr_id = m.ivr_id
  )
  where exists (
    select 1 from ivr_modules as m where c.ivr_id = m.ivr_id
  );