package cn.qdu.controller;

import cn.qdu.dao.UserInfoDao;
import cn.qdu.entity.UserInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@Controller
public class RegisterController {

    @Autowired
    UserInfoDao userInfoDao;

    @RequestMapping("/registerCheck")
    public void registerCheck(HttpServletResponse response, HttpServletRequest request) throws IOException {
        //request.setCharacterEncoding("UTF-8");
        PrintWriter p = response.getWriter();
        String name = null;
        String email = null;
        String phone = null;
        if (request.getParameter("name") != null) {
            name = new String(request.getParameter("name").getBytes("iso-8859-1"), "utf-8");

        } else if (request.getParameter("email") != null) {
            email = new String(request.getParameter("email").getBytes("iso-8859-1"), "utf-8");

        } else {
            phone = new String(request.getParameter("phone").getBytes("iso-8859-1"), "utf-8");

        }

        UserInfo user = new UserInfo();
        user.setUserName(name);
        user.setEmail(email);
        user.setPhoneNumber(phone);
        if (userInfoDao.selectByUserNameOrEmailOrPhoneNumber(user) != null) {
            p.print("true");
        } else {
            p.print("false");
        }
        p.flush();
        p.close();
    }

    @RequestMapping("/register")
    public void register(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //request.setCharacterEncoding("UTF-8");
        UserInfo user = new UserInfo();
        user.setUserName(request.getParameter("name"));
        user.setEmail(request.getParameter("email"));
        user.setPhoneNumber(request.getParameter("phone"));
        user.setUserPass(request.getParameter("password"));
        user.setUserStatus("未锁定");
        int ret = userInfoDao.insert(user);
        //boolean ret = new UserDaoImpl().register(user);
        if (ret > 0) {
            response.getWriter().print("true");
            // response.sendRedirect("login.jsp");
        } else {
            response.getWriter().print("false");
            // response.sendRedirect("register.jsp");
        }
    }
}
