//%attributes = {}
//zz_test_sql_insert
//20260315 wat@tottori
//insert test

C_TEXT:C284($sql)

$sql:="INSERT INTO assign (as_pr_id, as_wo_id, as_assigner, as_reg_date, as_up_date, as_del_date, as_unreg_date)"
$sql:=$sql+" VALUES (4 6 6 2004-01-15 23:01:37+09 \n \n n\\)"
//$sql:="INSERT INTO project (pr_id, pr_code, pr_channel, pr_category, pr_name, pr_shortname, pr_cl_id, pr_assign_type, pr_reg_date, pr_up_date, pr_del_date, pr_start_date, pr_end_date, pr_budget_hours) VALUES (4\t6\t6\t2004-01-15 23:01:37+09\t\\N\t\\N\t\\N), (1\t6\t6\t20"+"04-01-15 23:02:21+09\t2004-01-15 23:03:05+09\t\\N\t2004-01-15 23:03:05+09), (2\t6\t6\t2004-01-15 23:02:21+09\t2004-01-15 23:03:05+09\t\\N\t2004-01-15 23:03:05+09), (4\t6\t6\t2004-01-15 23:02:21+09\t2004-01-15 23:03:05+09\t\\N\t2004-01-15 23:03:05+09)"

JCL_err_OnErrCall_sql($sql)
SQL LOGIN:C817(SQL_INTERNAL:K49:11; ""; "")
SQL EXECUTE:C820($sql)
SQL LOGOUT:C872
$error:=JCL_err_OnErrCall_stop
