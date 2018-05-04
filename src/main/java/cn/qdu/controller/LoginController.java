package cn.qdu.controller;

import cn.qdu.dao.UserInfoDao;
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
    @Autowired
    UserInfoDao userInfoDao;

    @ResponseBody
    @RequestMapping("/login")
    public String login(UserInfo userInfo, HttpSession session){
        String result = userService.login(userInfo);
        if ("true".equals(result)){
        // 登录成功将用户名和用户存入session
            session.setAttribute("name",userInfo.getUserName());
            UserInfo loginUserInfo = userInfoDao.findByNameAndPassword(userInfo);
            session.setAttribute("loginUserInfo",loginUserInfo);
            session.setMaxInactiveInterval(10 * 60 * 60);
        }
        return result;
    }

    @RequestMapping("/logout")
    public void logout(HttpServletRequest request){
        request.getSession().removeAttribute("name");
        request.getSession().removeAttribute("loginUserInfo");
        request.getSession().removeAttribute("productIdAndCount");
        request.getSession().removeAttribute("productInfoAndCount");
    }
}
