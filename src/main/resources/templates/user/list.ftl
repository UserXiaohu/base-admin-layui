<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="/lib/layui-v2.6.3/css/layui.css" media="all">
    <link rel="stylesheet" href="/css/public.css" media="all">
</head>
<body>
    <div class="layuimini-container">
        <div class="layuimini-main">
            <fieldset class="table-search-fieldset">
                <legend>搜索信息</legend>
                <div style="margin: 10px">
                    <div class="layui-form layui-form-pane">
                        <div class="layui-form-item">
                            <div class="layui-inline">
                                <label class="layui-form-label">用户名</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="username" autocomplete="off" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-inline">
                                <button type="submit" class="layui-btn layui-btn-primary" lay-submit lay-filter="data-search-btn"><i class="layui-icon"></i> 搜 索</button>
                            </div>
                        </div>
                    </div>
                </div>
            </fieldset>

            <script type="text/html" id="toolbarDemo">
                <div class="layui-btn-container">
                    <button class="layui-btn layui-btn-normal layui-btn-sm data-add-btn" lay-event="add"> 添加</button>
                    <button class="layui-btn layui-btn-sm layui-btn-danger data-delete-btn" lay-event="delete"> 删除</button>
                </div>
            </script>

            <table class="layui-hide" id="currentTableId" lay-filter="currentTableFilter"></table>

            <script type="text/html" id="currentTableBar">
                <a class="layui-btn layui-btn-normal layui-btn-xs data-count-edit" lay-event="edit">编辑</a>
                <a class="layui-btn layui-btn-xs layui-btn-danger data-count-delete" lay-event="delete">删除</a>
            </script>

        </div>
    </div>
    <script src="/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
    <script>
        layui.use(['form', 'table'], function () {
            var $ = layui.jquery,
                form = layui.form,
                table = layui.table;

            table.render({
                elem: '#currentTableId',
                url: '/user/list',
                toolbar: '#toolbarDemo',
                defaultToolbar: ['filter', 'exports', 'print', {
                    title: '提示',
                    layEvent: 'LAYTABLE_TIPS',
                    icon: 'layui-icon-tips'
                }],
                cols: [[
                    {type: "checkbox", width: 50},
                    {field: 'id', width: 80, title: 'ID', sort: true},
                    {field: 'username', title: '用户名'},
                    {field: 'gender', width: 80, title: '性别', sort: true},
                    {field: 'phone', title: '电话'},
                    {field: 'email', title: '邮箱'},
                    {
                        field: 'role', title: '角色', templet: function (user) {
                            return user.role.title;
                        }
                    },
                    {title: '操作', minWidth: 150, toolbar: '#currentTableBar', align: "center"}
                ]],
                page: true,
                skin: 'line'
            });

            // 监听搜索操作
            form.on('submit(data-search-btn)', function (data) {
                var result = JSON.stringify(data.field);
                layer.alert(result, {
                    title: '最终的搜索信息'
                });

                //执行搜索重载
                table.reload('currentTableId', {
                    page: {
                        curr: 1
                    }
                    , where: {
                        searchParams: result
                    }
                }, 'data');

                return false;
            });

            /**
             * toolbar监听事件
             */
            table.on('toolbar(currentTableFilter)', function (obj) {
                if (obj.event === 'add') {  // 监听添加操作
                    var index = layer.open({
                        title: '添加用户',
                        type: 2,
                        shade: 0.2,
                        maxmin: true,
                        shadeClose: true,
                        area: ['700px', '600px'],
                        content: '/user/add',
                    });
                    $(window).on("resize", function () {
                        layer.full(index);
                    });
                } else if (obj.event === 'delete') {  // 监听删除操作
                    var checkStatus = table.checkStatus('currentTableId')
                        , data = checkStatus.data;
                    layer.alert(JSON.stringify(data));
                }
            });

            //监听表格复选框选择
            table.on('checkbox(currentTableFilter)', function (obj) {
                console.log(obj)
            });

            table.on('tool(currentTableFilter)', function (obj) {
                var data = obj.data;
                if (obj.event === 'edit') {

                    var index = layer.open({
                        title: '编辑用户',
                        type: 2,
                        shade: 0.2,
                        maxmin: true,
                        shadeClose: true,
                        area: ['700px', '600px'],
                        content: '/user/edit?id=' + data.id,
                    });
                    $(window).on("resize", function () {
                        layer.full(index);
                    });
                    return false;
                } else if (obj.event === 'delete') {
                    layer.confirm('真的删除行么', function (index) {
                        $.ajax({
                            url: "/user/delete",
                            type: "delete",
                            data: {
                                id: data.id
                            },
                            success: function (res) {
                                console.log(res)
                                obj.del();
                                layer.close(index);
                            }
                        })
                    });
                }
            });

        });
    </script>

</body>
</html>