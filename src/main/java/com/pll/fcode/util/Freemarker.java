package com.pll.fcode.util;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.Locale;
import java.util.Map;

import com.pll.fcode.Config;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

/**
 * 
* @ClassName: Freemarker.java
* @Description: 该类的功能描述
* @version: v1.0.0
* @author: pll
* @date: 2018年3月30日 下午5:37:53
 */
public class Freemarker {

	/**
	 * 输出到输出到文件
	 * @param ftlName   ftl文件名
	 * @param root		传入的map
	 * @param outFile	输出后的文件全部路径
	 * @param filePath	输出前的文件上部路径
	 */
	public static void printFile(String ftlName, Map<String,Object> root, String outFile){
		try {
			String filePath=Config.BASE_URL+Config.CODEBASE_URL;
			String fileName = System.getProperty("user.dir") + filePath + outFile;
			File file = new File(fileName);
			if(!file.getParentFile().exists()){				//判断有没有父路径，就是判断文件整个路径是否存在
				file.getParentFile().mkdirs();				//不存在就全部创建
			}
			Writer out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file), "utf-8"));
			Template template= getTemplate(ftlName);
			template.process(root, out);					//模版输出
			out.flush();
			out.close();
			System.err.println("生成"+outFile+"文件成功！");
		} catch (TemplateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 通过文件名加载模版
	 * @param ftlName
	 */
	public static Template getTemplate(String ftlName) throws Exception{
		try {
			//通过Freemaker的Configuration读取相应的ftl
			Configuration cfg = new Configuration();  												
			cfg.setEncoding(Locale.CHINA, "utf-8");
			//设定去哪里读取相应的ftl模板文件
			cfg.setDirectoryForTemplateLoading(new File(PathUtil.getClassResources()+"/ftl/"));
			//在模板文件目录中找到名称为name的文件
			return cfg.getTemplate(ftlName);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
}
