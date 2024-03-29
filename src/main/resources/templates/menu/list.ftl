<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>menu</title>
    <link rel="stylesheet" href="/lib/layui-v2.6.3/css/layui.css" media="all">
    <link rel="stylesheet" href="/css/public.css" media="all">
    <style>
        .layui-btn:not(.layui-btn-lg ):not(.layui-btn-sm):not(.layui-btn-xs) {
            height: 34px;
            line-height: 34px;
            padding: 0 8px;
        }
    </style>
</head>
<body>
    <div class="layuimini-container">
        <div class="layuimini-main">
            <div>
                <button class="layui-btn layui-btn-sm layui-btn-normal" id="add">添加</button>
                <table id="munu-table" class="layui-table" lay-filter="munu-table"></table>
            </div>
        </div>
    </div>
    <!-- 操作列 -->
    <script type="text/html" id="auth-state">
        <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="edit">修改</a>
        <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    </script>

    <script src="/lib/layui-v2.6.3/layui.js" charset="utf-8"></script>
    <script src="/js/lay-config.js?v=1.0.4" charset="utf-8"></script>
    <script>
        layui.use(['table', 'treetable'], function () {
            var $ = layui.jquery;
            var table = layui.table;
            var treetable = layui.treetable;

            // 渲染表格
            layer.load(2);
            treetable.render({
                treeColIndex: 1,
                treeSpid: -1,
                treeIdName: 'authorityId',
                treePidName: 'parentId',
                elem: '#munu-table',
                url: '/api/menus.json',
                page: false,
                cols: [[
                    {type: 'numbers'},
                    {field: 'authorityName', minWidth: 200, title: '权限名称'},
                    {field: 'authority', title: '权限标识'},
                    {field: 'menuUrl', title: '菜单url'},
                    {field: 'orderNumber', width: 80, align: 'center', title: '排序号'},
                    {
                        field: 'isMenu', width: 80, align: 'center', templet: function (d) {
                            if (d.isMenu == 1) {
                                return '<span class="layui-badge layui-bg-gray">按钮</span>';
                            }
                            if (d.parentId == -1) {
                                return '<span class="layui-badge layui-bg-blue">目录</span>';
                            } else {
                                return '<span class="layui-badge-rim">菜单</span>';
                            }
                        }, title: '类型'
                    },
                    {templet: '#auth-state', width: 120, align: 'center', title: '操作'}
                ]],
                done: function () {
                    layer.closeAll('loading');
                }
            });

            //监听工具条
            table.on('tool(munu-table)', function (obj) {
                var data = obj.data;
                var layEvent = obj.event;

                if (layEvent === 'del') {
                    layer.msg('删除' + data.id);
                } else if (layEvent === 'edit') {
                    layer.msg('修改' + data.id);
                }
            });
        });
    </script>
</body>
</html>