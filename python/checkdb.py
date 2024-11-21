import config
import oracledb
import io

con = oracledb.connect(user=config.user, password=config.password, dsn=config.dsn, config_dir = config.config_dir )

#cur = con.cursor()

#cur.execute("select * from mpf_investment")
#num_rows = 28
#res = cur.fetchmany(num_rows)
#print(res)
msg = ""
with con.cursor() as cursor:
	print("check error")
	error_sql = "SELECT a.*, to_char(ERR_DATE, 'HH:MI:SS') as err_time FROM ERROR_LOG a WHERE to_char(ERR_DATE, 'DD-MON-YY')= to_char(current_date,'DD-MON-YY') ORDER BY ERR_DATE,err_time"
	for result in cursor.execute(error_sql):
		msg = msg + str(result) +"\n"
		print(result)
	uni_emp = "SELECT 'EMPLOYER_CODE='||Fcc2(EMPLOYER_CODE)||' AND '||'FUND_CODE='||Fcc2(FUND_CODE)||' AND '||'SCHEME_NUMBER='||Fcc2(SCHEME_NUMBER) FROM STG_MPF_EMPLOYER GROUP BY EMPLOYER_CODE, FUND_CODE, SCHEME_NUMBER HAVING COUNT(1)>1"
	print("check unique employer")
	for result in cursor.execute(uni_emp):
		msg = msg + str(result) +"\n"
		print(result)
	print("check salary history")
	sal_his = "SELECT 'FUND_CODE='||Fcc2(FUND_CODE)||' AND '||'MEMBER_NUMBER='||Fnc2(MEMBER_NUMBER) FROM STG_MPF_MEMBER_SALARY_HISTORY a WHERE  NOT EXISTS (  SELECT NULL FROM MPF_MEMBER b WHERE  a.FUND_CODE = b.FUND_CODE AND  a.MEMBER_NUMBER = b.MEMBER_NUMBER)and NOT EXISTS (  SELECT NULL FROM stg_MPF_MEMBER b WHERE  a.FUND_CODE = b.FUND_CODE AND  a.MEMBER_NUMBER = b.MEMBER_NUMBER)"
	for result in cursor.execute(sal_his):
		msg = msg + str(result) +"\n"
		print(result)
		
	print("check unit balance")
	unit_bal = "SELECT 'FUND_CODE='||Fcc2(FUND_CODE)||' AND '||'MEMBER_NUMBER='||Fnc2(MEMBER_NUMBER) FROM stg_MPF_UNIT_BALANCE a WHERE  NOT EXISTS (  SELECT NULL FROM MPF_MEMBER b WHERE  a.FUND_CODE = b.FUND_CODE AND  a.MEMBER_NUMBER = b.MEMBER_NUMBER)and NOT EXISTS (  SELECT NULL FROM stg_MPF_MEMBER b WHERE  a.FUND_CODE = b.FUND_CODE AND  a.MEMBER_NUMBER = b.MEMBER_NUMBER)"
	for result in cursor.execute(unit_bal):
		msg = msg + str(result) +"\n"
		print(result)
	
	print("check mov tran")
	mov_tran = "SELECT 'FUND_CODE='||Fcc2(FUND_CODE)||' AND '||'MEMBER_NUMBER='||Fnc2(MEMBER_NUMBER) FROM STG_MPF_UNIT_MOVEMENT_TRAN a WHERE  NOT EXISTS (  SELECT NULL FROM MPF_MEMBER b WHERE  a.FUND_CODE = b.FUND_CODE AND  a.MEMBER_NUMBER = b.MEMBER_NUMBER)and NOT EXISTS (  SELECT NULL FROM stg_MPF_MEMBER b WHERE  a.FUND_CODE = b.FUND_CODE AND  a.MEMBER_NUMBER = b.MEMBER_NUMBER)"
	for result in cursor.execute(mov_tran):
		msg = msg + str(result) +"\n"
		print(result)
	
	print("check reason")
	reason = "SELECT 'FUND_CODE='||Fcc2(FUND_CODE)||' AND '||'MEMBER_NUMBER='||Fnc2(MEMBER_NUMBER) FROM stg_MPF_TRANSFER_IN_REASON a WHERE  NOT EXISTS (  SELECT NULL FROM MPF_MEMBER b WHERE  a.FUND_CODE = b.FUND_CODE AND  a.MEMBER_NUMBER = b.MEMBER_NUMBER)and NOT EXISTS (  SELECT NULL FROM stg_MPF_MEMBER b WHERE  a.FUND_CODE = b.FUND_CODE AND  a.MEMBER_NUMBER = b.MEMBER_NUMBER)"
	for result in cursor.execute(reason):
		msg = msg + str(result) +"\n"
		print(result)
	
	print("check mandate")
	mandate = "SELECT 'FUND_CODE='||Fcc2(FUND_CODE)||' AND '||'MEMBER_NUMBER='||Fnc2(MEMBER_NUMBER) FROM STG_MPF_MEMBER_INVEST_MANDATE a WHERE  NOT EXISTS (  SELECT NULL FROM MPF_MEMBER b WHERE  a.FUND_CODE = b.FUND_CODE AND  a.MEMBER_NUMBER = b.MEMBER_NUMBER)and NOT EXISTS (  SELECT NULL FROM stg_MPF_MEMBER b WHERE  a.FUND_CODE = b.FUND_CODE AND  a.MEMBER_NUMBER = b.MEMBER_NUMBER)"
	for result in cursor.execute(mandate):
		msg = msg + str(result) +"\n"
		print(result)

with io.open("C:/Users/l230445/Documents/B02/script/input.txt",'w',encoding='utf-8') as outfile:
	outfile.write(msg)
