alter table ivr_calls
  add column if not exists document_type string,
  add column if not exists document_identification string;


update ivr_calls as c
  set
    c.document_type = d.document_type,
    c.document_identification = d.document_identification
  from (
    select 
      calls_ivr_id,
      document_type,
      document_identification,
      row_number() over (partition by cast(calls_ivr_id as string) order by calls_start_date desc) as rn
    from ivr_detail
  ) as d
  where cast(c.ivr_id as string) = cast(d.calls_ivr_id as string)
    and d.rn = 1;