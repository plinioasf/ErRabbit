<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <jsp:include page="../common/header_include.jsp"/>
    <link rel="stylesheet" href="/css/log.css" type="text/css"/>
    <link rel="stylesheet" href="/css/console.css" type="text/css"/>
    <script src="/js/sockjs-0.3.4.js"></script>
    <script src="/js/stomp.js"></script>
    <script src="/js/console.js"></script>
</head>
<body class="console">
<jsp:include page="../common/nav.jsp">
    <jsp:param name="console" value="active"/>
</jsp:include>
<div class="page-navi">
    <ul>
        <%--<li><span class="glyphicon glyphicon-globe" aria-hidden="true"></span> STATUS </li>--%>
        <%--<li id="con_connecting"><span class="label label-warning">CONNECTING</span></li>--%>
        <%--<li id="con_success"><span class="label label-success">CONNECTED</span></li>--%>
        <%--<li id="con_fail"><span class="label label-danger">DISCONNECTED</span></li>--%>
        <li class="filter" data-toggle="modal" data-target="#filterModal" id="filter_button">
            <span class="glyphicon glyphicon-filter glyphicon" aria-hidden="true"></span>
            <span id="filter_button_text">FILTER</span>
        </li>
    </ul>
</div>
<section class="page">
    <div class="log-area log-area_nosidebar" id="log-area">

        <div class="log-timeLine">
            <!-- Log Time Line Area-->
        </div>
        <div class="log-list-box">
            <div id="waiting">
                <div class="panel panel-default">
                    <div class="panel-heading"><span class="glyphicon glyphicon-ok-sign" aria-hidden="true"></span> Waiting for new log</div>
                    <div class="panel-body">
                        <p>WebSocket connection is succeed. Log will be appear as arriving. Do not refresh this page.</p>
                    </div>
                </div>
            </div>
            <div style="clear:both;"></div>
            <ul class="log-list" id="log-list">
                <!--  Log List Area -->
                <c:if test="${not empty preload}">
                    <c:forEach items="${preload}" var="row">
                        ${row.toHTML(true)}
                    </c:forEach>
                </c:if>
            </ul>
        </div>
        <div id="retry">
            <div class="panel panel-warning">
                <div class="panel-heading">WebSocket connection failed</div>
                <div class="panel-body">
                    <p>Please retry with refresh this page</p>
                </div>
                <div class="panel-footer">
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Filter Modal -->
<div class="modal fade" id="filterModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Filter</h4>
            </div>
            <input type="hidden" id="filter_init" value="${param.filter}"/>

            <div class="modal-body">
                <div class="input-group">
                    <label class="control-label">LEVEL</label>
                    <select id="filter_level" name="level" class="form-control">
                        <option value="ALL" <c:if test="${param.filter_level == 'ALL'}">selected</c:if>>ALL</option>
                        <option value="TRACE" <c:if test="${param.filter_level == 'TRACE'}">selected</c:if>>TRACE</option>
                        <option value="DEBUG" <c:if test="${param.filter_level == 'DEBUG'}">selected</c:if>>DEBUG</option>
                        <option value="INFO" <c:if test="${param.filter_level == 'INFO'}">selected</c:if>>INFO</option>
                        <option value="WARN" <c:if test="${param.filter_level == 'WARN'}">selected</c:if>>WARN</option>
                        <option value="ERROR" <c:if test="${param.filter_level == 'ERROR'}">selected</c:if>>ERROR</option>
                        <option value="FATAL" <c:if test="${param.filter_level == 'FATAL'}">selected</c:if>>FATAL</option>
                    </select>
                </div>
                <hr/>
                <div class="input-group" style="width:100%">
                    <label class="control-label">CLASS NAME</label>
                    <input id="filter_class" name="class" type="text" class="form-control"
                           placeholder="org.mintcode.errabbit.Server" style="width:100%"
                            value="${param.filter_class}">
                </div>
            </div>
            <div class="modal-footer">
                <button id="filter_clear" type="button" class="btn btn-default">CLEAR</button>
                <button id="filter_apply" type="submit" class="btn btn-primary">APPLY</button>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../common/footer.jsp"/>
<jsp:include page="../log/popover_view.jsp"/>
</body>
</html>
