package ${structure}.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ${structure}.entity.${objectName};
import ${structure}.mapper.${objectName}Mapper;
import ${structure}.service.${objectName}Service;

/** 
 * 类名称：${objectName}ServiceImpl
 * 创建人：${author}
 * 创建时间：${nowDate?string("yyyy-MM-dd")}
 */
@Service
public class ${objectName}ServiceImpl implements ${objectName}Service{
	
	@Autowired  
    private ${objectName}Mapper ${objectNameLower}Mapper;

	@Override
	public void add(${objectName} ${objectNameLower}) {
		${objectNameLower}Mapper.insert(${objectNameLower});
	}

	@Override
	public void edit(${objectName} ${objectNameLower}) {
		${objectNameLower}Mapper.update(${objectNameLower});
	}

	@Override
	public void delete(String[] ids) {
		${objectNameLower}Mapper.delete(ids);
	}

	@Override
	public List<${objectName}> queryAll() {
		return ${objectNameLower}Mapper.selectAll();
	}

	@Override
	public ${objectName} findById(String id) {
		return ${objectNameLower}Mapper.findById(id);
	}

	@Override
	public List<${objectName}> queryByPage(Map<String, Object> map) {
		return ${objectNameLower}Mapper.queryByPage(map);
	}



	
	
}
