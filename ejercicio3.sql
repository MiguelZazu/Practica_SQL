create table ivr_detail as
  select
    c.ivr_id as calls_ivr_id,
    c.phone_number as calls_phone_number,
    c.ivr_result as calls_ivr_result,
    c.vdn_label as calls_vdn_label,
    c.start_date as calls_start_date,
    format_date('%Y%m%d', c.start_date) as calls_start_date_id,
    c.end_date as calls_end_date,
    format_date('%Y%m%d', c.end_date) as calls_end_date_id,
    c.total_duration as calls_total_duration,
    c.customer_segment as calls_customer_segment,
    c.ivr_language as calls_ivr_language,
    c.steps_module as calls_steps_module,
    c.module_aggregation as calls_module_aggregation,
    m.module_sequece as module_sequece,
    m.module_name,
    m.module_duration,
    m.module_result,
    s.step_sequence,
    s.step_name,
    s.step_result,
    s.step_description_error,
    s.document_type,
    s.document_identification,
    s.customer_phone,
    s.billing_account_id
  from
    ivr_calls c
  left join
    ivr_modules m
    on
    c.ivr_id = m.ivr_id
  left join
    ivr_steps s
    on
    m.ivr_id = s.ivr_id
    and m.module_sequece = s.module_sequece;