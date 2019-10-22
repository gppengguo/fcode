<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>XXX</title>
    <link rel="shortcut icon" href="${r"${"}ctx}/static/img/sys/favicon.ico" type="image/x-icon">
</head>
<body class="nav-md">
<div class="container body">
    <div class="main_container">

    ${r"<#"}include "/common/com.ftl">

        <!-- page content -->
        <div class="right_col" role="main" id="main">

            <div class="container">
                <form id="searchForm" class="form-inline">
                    <#--<div class="form-group">-->
                        <#--<label for="adminTel">手机号：</label>-->
                        <#--<input class="form-control" type="text" name="adminTel">-->
                    <#--</div>-->
                </form>
                <p class="toolbar">
                    <a class="create btn btn-success" href="javascript:">新增用户</a>
                </p>
                <table id="table" data-toggle="table" data-show-refresh="true"
                       data-show-columns="true" data-toolbar=".toolbar" data-pagination="true"
                       data-content-type="application/x-www-form-urlencoded"
                       data-method="post" data-query-params="queryParams"
                       data-detail-view="false" data-detail-formatter="detailFormatter"
                       data-side-pagination="server" data-url="${r"${"}ctx}/${objectNameLower}/list">
                    <thead>
                    <tr>
                        <th data-formatter="serialFormatter" data-width="60">序号</th>
                        <#list fieldList as pro>
                        <th data-field="${pro.proName}">${pro.comment}</th>
                        </#list>
                        <th data-field="action" data-align="center"
                            data-formatter="actionFormatter" data-events="actionEvents">
                            操作
                        </th>
                    </tr>
                    </thead>
                </table>

                <div id="modal" class="modal fade" aria-hidden="true" data-backdrop="static" data-keyboard="false">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal"
                                        aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                                <h4 class="modal-title"></h4>
                            </div>
                            <div class="modal-body">

                                <form class="form-horizontal" role="form">
                                   
                                    <#list fieldList as pro>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">${pro.comment}</label>
                                        <div class="col-sm-10">
                                            <input type="text" class="form-control" name="${pro.proName}">
                                        </div>
                                    </div>
                                    </#list>

                                </form>

                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                <button type="button" class="btn btn-primary submit">确定</button>
                            </div>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal-dialog -->
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${r"${"}ctx}/static/gentelella/build/js/common.js"></script>

<script>

    var $table = $('#table').bootstrapTable(),
            $modal = $('#modal').modal({
                show : false
            }).on('hide.bs.modal', function() {
                $modal.data('bootstrapValidator').resetForm();
            });

    $(function () {
        // 新增
        $('.create').click(function () {
            showModal($(this).text());
        });

        //查询
        $('.search').click(function () {
            $table.bootstrapTable('refresh');
        });

        //提交表单
        $modal.find('.submit').click(function() {
            //验证
            $modal.bootstrapValidator('validate');
            if ($modal.data('bootstrapValidator').isValid()) {

                var row = {};
                $modal.find('input[name],select[name]').each(
                    function() {
                        row[$(this).attr('name')] = $(this).val();
                    }
                );

                $.ajax({
                    url: row['${objectNameLower}Id'] ? '${r"${"}ctx}/${objectNameLower}/edit'
                            : '${r"${"}ctx}/${objectNameLower}/add',
                    type: 'post',
                    data: JSON.stringify(row),
                    headers: {'Accept': 'application/json', 'Content-Type': 'application/json'},
                    dataType: 'json',
                    success: function (data) {
                        layer.msg(data.message, {icon: data.icon});
                        if (data.status == "success") {
                            $modal.modal('hide');
                            $table.bootstrapTable('refresh');
                        }
                    },
                    error: function () {
                        layer.msg("未知错误，请联系管理员！", {icon: 2});
                    }
                });
            }
        });

        //验证
        $modal.bootstrapValidator({
            message : '此项未验证！',
            feedbackIcons : {
                valid : 'glyphicon glyphicon-ok',
                invalid : 'glyphicon glyphicon-remove',
                validating : 'glyphicon glyphicon-refresh'
            },
            fields : {
                adminName : {
                    trigger : 'blur',
                    validators : {
                        notEmpty : {
                            message : '用户名不能为空'
                        },
                        stringLength:{
                            min:1,
                            max: 20,
                            message: '用户名长度不能超过20位'
                        },
                        regexp:{
                            regexp: '^([\u4E00-\uFA29]|[\uE7C7-\uE7F3]|[a-zA-Z0-9]){1,20}$',
                            message:'用户名不符合规则'
                        }
                    }
                },
                adminTel : {
                    trigger : 'blur',
                    validators : {
                        notEmpty : {
                            message : '手机号不能为空'
                        },
                        // regexp:{
                        //     regexp:/^[a-zA-Z0-9_-]{3,16}$/,
                        //     message:'请输入正确的手机号'
                        // }
                    }
                },
            },
        });

    });

    function queryParams(params) {
        $("#searchForm").find('input[name],select[name]').each(function () {
            params[$(this).attr('name')] = $(this).val();
        });
        return params;
    }

    function actionFormatter(value) {
        return [
            '<a class="update" href="javascript:" title="修改用户"><i class="glyphicon glyphicon-edit"></i></a>',
            '<a class="remove" href="javascript:" title="删除"><i class="glyphicon glyphicon-remove-circle"></i></a>',]
                .join('');
    }
    // update and delete events
    window.actionEvents = {
        'click .update' : function(e, value, row) {
            showModal($(this).attr('title'), row);
        },
        'click .remove' : function(e, value, row) {
            layer.confirm('确定删除吗？', {icon: 3, title: '确定删除吗？'}, function (index) {

                //删除请求
                $.ajax({
                    url: "${r"${"}ctx}/carousel/del?id=" + row.id,
                    type: 'get',
                    async: false,
                    success: function (data) {
                        layer.msg(data.message, {icon: data.icon});
                        if (data.status == "success") {
                            $table.bootstrapTable('refresh');
                        }
                    },
                    error: function () {
                        layer.msg("未知错误，请联系管理员！", {icon: 2});
                    }
                });
            });
        }
    };

    //显示菜单管理model
    function showModal(title, row) {
        row = row || {
            <#list fieldList as pro>
            ${pro.proName} : '',
            </#list>
        }; // default row value

        $modal.find('.modal-title').text(title);
        for ( var name in row) {
            $modal.find('input[name="' + name + '"],select[name="' + name + '"]').val(row[name]);
        }

        $modal.modal('show');
    }


</script>
</body>
</html>