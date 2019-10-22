<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd"><!--$NO-MVN-MAN-VER$-->
<mapper namespace="${structure}.mapper.${objectName}Mapper">

	<resultMap type="${objectName}" id="${objectName}ResultMap">
	<#list fieldList as pro>  
	    <result property="${pro.proName}" column="${pro.fieldName}" /> 
	</#list>
	</resultMap>

	<sql id="selectId">
	<#list fieldList as pro> ${pro.fieldName},</#list>
	</sql>
	
	<select id="selectAll" resultMap="${objectName}ResultMap">
		SELECT
		<include refid="selectId" />
		FROM ${tableName}
	</select>
	
	<insert id="insert" parameterType="${objectName}">
		INSERT INTO ${tableName}
		(<#list fieldList as pro> ${pro.fieldName},</#list>)
		VALUES
		(<#list fieldList as pro> ${r"#{"}${pro.proName}},</#list>)
	</insert>

	<update id="update" parameterType="${objectName}">
		UPDATE ${tableName}
		<set>
		<#list fieldList as pro>
			<if test="${pro.proName} != null">
			${pro.fieldName}=${r"#{"}${pro.proName}},
			</if>
	    </#list>
		</set>
	    where ${firstFieldName}=${r"#{"}${firstProName}}
	</update>

	<delete id="delete">
		DELETE FROM  ${tableName} WHERE ${firstFieldName} IN
		<foreach collection="array" index="index" item="item" open="("
			separator="," close=")">
			${r"#{"}item}
		</foreach>
	</delete>
	
	<select id="findById" parameterType="String" resultMap="${objectName}ResultMap">
		SELECT * FROM  ${tableName} 
		WHERE ${firstFieldName}=${r"#{"}${firstProName}}
	</select>
	
	<select id="queryByPage" parameterType="map" resultMap="${objectName}ResultMap">
		SELECT
		<include refid="selectId" />
		FROM ${tableName}
		ORDER BY ${firstFieldName} desc
	</select>
	
</mapper>