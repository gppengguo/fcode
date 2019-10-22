package com.pll.fcode.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.pll.fcode.Config;

/**
 * 连接数据库操作工具类
 * 项目名称：cmsapp
 * 类名称：DbUtil 
 * 类描述： 
 * 创建人：pll 
 * 创建时间：2017年5月24日 上午10:15:02
 * 修改人：pll 
 * 修改时间：2017年5月24日 上午10:15:02
 * 修改备注： 
 * @version
 */
public class DbUtil {
	
	
	public static List<FieldBean> getAllColums(){
		ArrayList<FieldBean> returnList = new ArrayList<FieldBean>();
		try {
			//加载驱动
			Class.forName(Config.DriverName);
			//连接数据库
			Connection con = DriverManager.getConnection(Config.cnnStr,Config.username,Config.password);
			Statement stm = con.createStatement();
			ResultSet rs = stm.executeQuery("show full columns from " + Config.tableName);

//			String str="select ";
			while (rs.next()) {     
              //表字段
 			   String columName =rs.getString("Field");

// 			   str+="AES_DECRYPT("+columName+",'mvyKuDYuQzw6sL8wdd3us2KuJYuBowp1jLO1Em') as "+columName+",";
 			   //表类型
 			   String dataType =getTypeName(rs.getString("Type"));
 			   //字段转换
 			   String proName = convertField(columName);  
 			   //注释
 			   String comment=rs.getString("Comment");
 			   
 			   FieldBean fieldBean = new FieldBean();  
			   fieldBean.setFieldName(columName);  
			   fieldBean.setProName(proName);  
			   fieldBean.setProType(dataType);
			   fieldBean.setComment(comment);
			   returnList.add(fieldBean);  
            }
//			System.out.println(str+" from "+Config.tableName+"_encrypt");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	}
	
	
	/**
	 * 把数据库中的字段转换为变量类型
	 * 如（user_id ----> userId）
	 * @param field
	 * @return
	 */
	public static String convertField(String field) {
		//分隔符
		char separator = '_';
		//转化为小写
		String variable = field.toLowerCase();
		
		if (variable.indexOf(separator)>-1) {
			char[] varArray = variable.toCharArray();
			for(int i=0;i<varArray.length;i++){
				if (varArray[i]==separator&&i<varArray.length-1) {
					varArray[i+1]=Character.toUpperCase(varArray[i+1]);
				}
			}
			variable = new String(varArray).replaceAll("_", "");
		}
		
		return variable;
		
	}	
	
	/**获取字符串型的类型名
	 * @param type
	 * @return
	 */
	private static String getTypeName(String type){
		String typeName = String.class.getSimpleName();
		if(type.indexOf("varchar")>-1){
			typeName = String.class.getSimpleName();
		}else if(type.indexOf("int")>-1){
			typeName=Integer.class.getSimpleName();
		}else if(type.indexOf("double")>-1){
			typeName=Double.class.getSimpleName();
		}else if(type.indexOf("timestamp")>-1){
			typeName=Date.class.getSimpleName();
		}else if(type.indexOf("float")>-1){
			typeName=Float.class.getSimpleName();
		}else if(type.indexOf("boolean")>-1){
			typeName=Boolean.class.getSimpleName();
		}
		return typeName;
		
	}
	
}
