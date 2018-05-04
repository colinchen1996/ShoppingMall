package cn.qdu.controller;

import cn.qdu.dao.*;
import cn.qdu.entity.AddressInfo;
import cn.qdu.entity.OrderInfo;
import cn.qdu.entity.UserInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@Controller
public class UserInfoController {

    @Autowired
    AddressInfoDao addressInfoDao;
    @Autowired
    UserInfoDao userInfoDao;
    @Autowired
    OrderInfoDao orderInfoDao;
    @Autowired
    OrderItemDao orderItemDao;
    @Autowired
    ProductInfoDao productInfoDao;

    @RequestMapping("/deleteUserAddress")
    public void deleteUserInfoAddress(int addressId, HttpServletRequest request, HttpServletResponse response) {
        AddressInfo addressInfo = addressInfoDao.selectByPrimaryKey(addressId);
        addressInfoDao.deleteByPrimaryKey(addressId);
        List<AddressInfo> addressList = addressInfoDao.selectByUserId(addressInfo.getUserId());
        request.getSession().setAttribute("addressList", addressList);
        try {
            response.sendRedirect("userInfo.jsp");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("/getUserInfo")
    public void getUserInfo(HttpServletResponse response, HttpSession session) {
        UserInfo userInfo = (UserInfo) session.getAttribute("loginUserInfo");
        List<AddressInfo> addressList = addressInfoDao.selectByUserId(userInfo.getUserId());
        List<OrderInfo> orderList = orderInfoDao.selectByUserId(userInfo.getUserId());
        session.setAttribute("addressList", addressList);
        session.setAttribute("orderList", orderList);
        session.setMaxInactiveInterval(10 * 60 * 60);
        try {
            response.sendRedirect("userInfo.jsp");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("/getUserAddress")
    public void getUserAddress(HttpSession session) {
        UserInfo userInfo = (UserInfo) session.getAttribute("loginUserInfo");
        List<AddressInfo> addressList = addressInfoDao.selectByUserId(userInfo.getUserId());
        session.setAttribute("addressList", addressList);
    }

    @RequestMapping("/addAddress")
    public void addAddress(AddressInfo address, String userName, HttpServletRequest request, HttpServletResponse response) {
        int userId = userInfoDao.selectUserIdByUserName(userName);
        address.setUserId(userId);
        int result = addressInfoDao.insert(address);
        if (result > 0) {
            List<AddressInfo> addressList = addressInfoDao.selectByUserId(userId);
            request.getSession().setAttribute("addressList", addressList);
            try {
                response.getWriter().print(0);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    @RequestMapping("/updateUserInfo")
    public void updateUserInfo(UserInfo user, HttpServletRequest request, HttpServletResponse response) {
        int userId = userInfoDao.selectUserIdByUserName(user.getUserName());
        user.setUserId(userId);
        int result = userInfoDao.updateByPrimaryKeySelective(user);
        if (result > 0) {
            UserInfo newUserInfo = userInfoDao.selectByUserName(user.getUserName());
            request.getSession().setAttribute("userInfo", newUserInfo);
            try {
                response.sendRedirect("userInfo.jsp");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
