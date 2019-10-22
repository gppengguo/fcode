package com.pll.fcode.util;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.pll.fcode.Config;

/**
 * 根据模板生成代码
* @ClassName: CreateCode.java
* @Description: 该类的功能描述
* @version: v1.0.0
* @author: pll
* @date: 2018年3月31日 下午1:37:34
 */
public class CreateCode {

	/**
	* @Description 生成代码
	* @Author pll
	* @Date 14:03 2019/10/10
	* @param
	* @return
	**/
	public static void createCode() {
		Map<String, Object> data=getData();

		Freemarker.printFile("beanModel.ftl", data, Config.objectName + ".java");//生成Bean
		Freemarker.printFile("mapperMysqlTemplate.ftl", data, Config.objectName + "Mapper.xml");//生成mapper配置文件
		Freemarker.printFile("mapperTemplate.ftl", data, Config.objectName + "Mapper.java");		//生成Mapper
		Freemarker.printFile("serviceTemplate.ftl", data, Config.objectName + "Service.java");//生成Service
		Freemarker.printFile("serviceImplTemplate.ftl", data, Config.objectName + "ServiceImpl.java");//生成ServiceImpl
		Freemarker.printFile("controllerTemplate.ftl", data, Config.objectName + "Controller.java");		//生成Controller
		Freemarker.printFile("managerTemplate.ftl", data, "manager.ftl");//生成ftl
		Freemarker.printFile("editTemplate.ftl", data, "edit.ftl");
	}

	
	public static Map<String, Object> getData() {
		// 根据数据库表获取属性
		List<FieldBean> list = DbUtil.getAllColums();

		// 创建数据模型
		Map<String, Object> data = new HashMap<String, Object>();
		// 类属性 fieldList
		data.put("fieldList", list);
		//包结构 例如 com.test.a
		data.put("structure", Config.structure);
		// 包名
		data.put("packageName", Config.packageName);
		// 类名
		data.put("objectName", Config.objectName);
		// 表名
		data.put("tableName", Config.tableName);
		// 类名(首字母小写)
		data.put("objectNameLower", Config.lowObjectName);
		// 类名(全大写)
		data.put("objectNameUpper", Config.upObjectName);
		//
		data.put("nowDate", new Date());
		data.put("author", Config.author);

		data.put("firstFieldName", list.get(0).getFieldName());
		data.put("firstProName", list.get(0).getProName());
		return data;
	}
	
	
	
}
