create function clean_integer(input INT64)
  returns INT64
  as (
    ifnull(input, -999999)
  );