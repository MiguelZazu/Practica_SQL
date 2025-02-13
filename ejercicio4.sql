alter table ivr_detail
    add column vdn_aggregation string;

update ivr_detail
    set vdn_aggregation = case
        when calls_vdn_label like 'ATC_%' then 'FRONT'
        when calls_vdn_label like 'TECH_%' then 'TECH'
        when calls_vdn_label = 'ABSORPTION' then 'ABSORPTION'
        else 'RESTO'
    end
where TRUE;