<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>XX添加/修改</title>
    <script src="${r"${"}ctx}/static/common.js"></script>
</head>
<body>
<div class="container-fluid" style="margin-top: 20px;">
    <div class="row">
        <div>
            <h3 id="title"></h3>
        </div>
        <div class="col-md-8" id="editForm">
            <#list fieldList as pro>
            <div class="form-group">
                <div class="input-control has-label-left-lg">
                    <input id="${pro.proName}" name="${pro.proName}" type="text" class="form-control" placeholder="">
                    <label for="${pro.proName}" class="input-control-label-left">${pro.comment}:</label>
                </div>
            </div>
            </#list>

            <div class="form-group" style="float: right;">
                <button type="button" class="back btn btn-muted">返回
                    <i class="icon icon-arrow-left"></i>
                </button>
                <button type="button" class="submit btn btn-success">提交
                    <i class="icon icon-check"></i>
                </button>
            </div>

        </div>
    </div>

</div>
<script>
    //设置值
    var data=${r"${"}data};
    var title=$("#title");
    if(data!=null){
        title.html("XX修改");
    }else{
        title.html("XX添加");
    }
    setEditFrom(data);

    //返回按钮
    $('.back').on("click",function(){
        mainContent.load('${r"${"}ctx}/${objectNameLower}/manager');
    });

    //提交按钮
    $('.submit').on("click",function(){
        var row=getEditForm();
        if(validate(row)){
            $.ajax({
                url : row['adminId'] ? '${r"${"}ctx}/${objectNameLower}/edit'
                    : '${r"${"}ctx}/${objectNameLower}/add',
                type : 'post',
                data : JSON.stringify(row),
                headers: { 'Accept': 'application/json','Content-Type':'application/json' },
                datatype: 'json',
                success : function(data) {
                    showAlert(data);
                    if(data.status=="success"){
                        mainContent.load('${r"${"}ctx}/${objectNameLower}/manager');
                    }
                },
                error : function() {
                    dangerAlert();
                }
            });
        }
    });

    //表单验证
    function validate(row){
        for(var i in row){
            if(row[i]==""){
                <#list fieldList as pro>
                if(i=="${pro.proName}"){
                    warningAlert("${pro.comment}不能为空！");
                    return false;
                }
                </#list>
            }
        }
        return true;
    }

</script>
</body>
</html>