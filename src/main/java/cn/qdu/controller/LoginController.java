package cn.qdu.controller;

import cn.qdu.entity.UserInfo;
import cn.qdu.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class LoginController {
    @Autowired
    UserService userService;


    @RequestMapping("test")
    public String index(){
        return "login";
    }

    @ResponseBody
    @RequestMapping("/login")
    public String login(UserInfo userInfo, HttpSession session){
        String result = userService.login(userInfo);
        if ("true".equals(result)){
        // 登录成功将用户名存入session
            session.setAttribute("name",userInfo.getUserName());
            session.setMaxInactiveInterval(10 * 60);
        }
        return result;
        /*if (list != null) {
            if (user.getUserName().equals("admin")) {
                response.getWriter().print("admin");
            } else if (list.get(0).getUserStatus().equals("已锁定")) {
                response.getWriter().print("已锁定");
            } else {
                request.getSession().setAttribute("name",
                        list.get(0).getUserName());
                request.getSession().setMaxInactiveInterval(10 * 60);
                // response.sendRedirect("index.jsp");
                response.getWriter().print("true");
            }

        } else {
            request.getSession().setAttribute("error", "密码错误，请重新登录！");
            // response.sendRedirect("login.jsp");
            response.getWriter().print("false");
        }*/
    }

    @RequestMapping("logOut")
    public void logOut(HttpServletRequest request){
        request.getSession().removeAttribute("name");
    }
}
