package  ${structure}.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import ${structure}.entity.sys.Page;
import ${structure}.entity.${objectName};
import ${structure}.service.${objectName}Service;

/**
 * ${objectName}controller类
* @ClassName: ${objectName}Controller.java
* @Description: 该类的功能描述
* @author: ${author}
* @date: ${nowDate?string("yyyy-MM-dd")}
 */
@Controller  
@RequestMapping("/${objectNameLower}")
public class ${objectName}Controller {

	@Autowired
	private ${objectName}Service ${objectNameLower}Service;
	
	@RequestMapping("/manager")
    public String manager() {
        return "${objectNameLower}/manager";  
    }

	@ResponseBody
	@RequestMapping("/list")
    public Map<String,Object> list(
            @ModelAttribute Page page,
            @ModelAttribute ${objectName} ${objectNameLower}) {

		Map<String, Object> map = new HashMap<>();

        try {
            map.put("${objectNameLower}",${objectNameLower});

            PageHelper.startPage(page.getCurrentPage(), page.getLimit());
            //分页查询
            List<${objectName}> ${objectNameLower}s = ${objectNameLower}Service.queryByPage(map);
    		PageInfo<${objectName}> pageInfo= new PageInfo<>(${objectNameLower}s);

			map.clear();
			map.put("rows", ${objectNameLower}s);
			map.put("total", pageInfo.getTotal());

        }catch (Exception e){
        	e.printStackTrace();
        }
        return map;
    }
	
	@ResponseBody
	@RequestMapping("add")
	public Map<String, Object> add(@RequestBody ${objectName} ${objectNameLower}) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			${objectNameLower}Service.add(${objectNameLower});
			map.put("message", "添加成功");
			map.put("status", "success");
			map.put("icon", "6");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("message", "添加失败");
			map.put("status", "error");
			map.put("icon", "5");
		}
		return map;
	}
	
	@ResponseBody
	@RequestMapping("edit")
	public Map<String, Object> edit(@RequestBody ${objectName} ${objectNameLower}) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			${objectNameLower}Service.edit(${objectNameLower});
			map.put("message", "修改成功");
			map.put("status", "success");
			map.put("icon", "6");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("message", "修改失败");
			map.put("status", "error");
			map.put("icon", "5");
		}
		return map;
	}

	@ResponseBody
	@RequestMapping("del")
	public Map<String, Object> del(@RequestParam(value = "id", required = true) String id) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			${objectNameLower}Service.delete(new String[]{id});
			map.put("message", "删除成功");
			map.put("status", "success");
			map.put("icon", "6");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("message", "删除失败");
			map.put("status", "error");
			map.put("icon", "5");
		}
		return map;
	}
	
	
}
