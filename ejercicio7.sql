alter table ivr_calls
  add column if not exists billing_account_id string;


update ivr_calls as c
  set
    c.billing_account_id = d.billing_account_id
  from (
    select 
      calls_ivr_id,
      billing_account_id,
      row_number() over (partition by cast(calls_ivr_id as string) order by calls_start_date desc) as rn
    from ivr_detail
  ) as d
  where cast(c.ivr_id as string) = cast(d.calls_ivr_id as string)
    and d.rn = 1;