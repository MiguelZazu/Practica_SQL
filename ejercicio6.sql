alter table ivr_calls
  add column if not exists customer_phone string;


update ivr_calls as c
  set
    c.customer_phone = d.customer_phone
  from (
    select 
      calls_ivr_id,
      customer_phone,
      row_number() over (partition by cast(calls_ivr_id as string) order by calls_start_date desc) as rn
    from ivr_detail
  ) as d
  where cast(c.ivr_id as string) = cast(d.calls_ivr_id as string)
    and d.rn = 1;