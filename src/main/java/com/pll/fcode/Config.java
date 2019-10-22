package com.pll.fcode;

import com.pll.fcode.util.CreateCode;

public class Config {
	
	//项目base路径
	public static final String BASE_URL="/src/main/java";
	
	//java代码存放路径
	public static final String CODEBASE_URL = "/com/pll/code/";
	
	/**
	 * MySql
	 */
	//数据库连接地址
	public static final String cnnStr = "jdbc:mysql://192.168.1.134:3306/lease";
	//数据库连接驱动
	public static final String DriverName = "com.mysql.jdbc.Driver";
	//账号 root
	public static final String username = "root";
	//密码	psd123456
	public static final String password = "psd123456";
	
	/**#######################################################**/

	//表名
	public static String tableName="gr_company_info";
	//类名
	public static String objectName="Bill";
	//类名（首字母小写）
	public static String lowObjectName="bill";
	//类名（全大写）
	public static String upObjectName="Bill";
	//包名
	public static String packageName="";
	//包结构 例如 com.test.a
	public static String structure="com.gr";
	//作者
	public static String author="pll";
	/**#######################################################**/
	
	
	public static void main(String[] args) {
		CreateCode.createCode();
	}


}
