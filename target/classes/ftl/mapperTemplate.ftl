package ${structure}.mapper;


import org.apache.ibatis.annotations.Mapper;

import ${structure}.entity.${objectName};
import ${structure}.mapper.base.BaseMapper;

/** 
 * 类名称：${objectName}Mapper
 * 创建人：${author}
 * 创建时间：${nowDate?string("yyyy-MM-dd")}
 */
@Mapper 
public interface ${objectName}Mapper extends BaseMapper<${objectName}>{
	
	
}
