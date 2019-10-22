package ${structure}.entity;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.Date;

/**
 * 类名称：${packageName}
 * 类描述： 
 * 创建人：${author} 
 */
@Getter
@Setter
public class ${objectName} implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
<#list fieldList as pro>  
    private  ${pro.proType} ${pro.proName};  //${pro.comment}
</#list>

	
	<#--//get||set方法-->
	<#--<#list fieldList as pro>  -->
	<#--public ${pro.proType} get${pro.proName}() {-->
		<#--return ${pro.proName};-->
	<#--}-->
	<#--public void set${pro.proName}(${pro.proType} ${pro.proName}) {-->
		<#--this.${pro.proName} = ${pro.proName};-->
	<#--}	-->
	<#--</#list>-->

}