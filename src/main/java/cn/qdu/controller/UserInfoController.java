package cn.qdu.controller;

import cn.qdu.dao.*;
import cn.qdu.entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
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
    public void deleteUserInfoAddress(HttpServletRequest request, HttpServletResponse response) {
        //request.setCharacterEncoding("utf-8");
        String addressId = request.getParameter("addressId");
        int id = Integer.valueOf(addressId).intValue();
        //AddressInfo address = new AddressInfo();
        //UserInfo user = new UserInfo();
        //address.setAddressId(i);
        //Object[] param = {address.getAddressId()};
        //List<UserInfo> userlist = new UserDaoImpl().select("SELECT u.userName FROM userinfo u where u.userId = (SELECT userId FROM addressinfo where addressId = ?)", param);
        //Object[] param1 = {userlist.get(0).getUserName() };
        //Boolean boolean1 = new AddressDaoImpl().deleteAddress("DELETE from addressinfo WHERE addressId = ?", param);
        addressInfoDao.deleteByPrimaryKey(id);
        //if (boolean1 == true) {
//			List<User> userlist1 = new UserDaoImpl().select("SELECT * from userinfo where userName = ?", param1);
        //List<AddressInfo> addresslist = new AddressDaoImpl().selectAddress("SELECT a.* from userinfo u,addressinfo a WHERE a.userId=u.userId AND u.userName = ?", param1);
        AddressInfo addressInfo = addressInfoDao.selectByPrimaryKey(id);
        List<AddressInfo> addresslist = addressInfoDao.selectByUserId(addressInfo.getUserId());
        request.getSession().setAttribute("addresslist", addresslist);
        try {
            response.sendRedirect("userInfo.jsp");
        } catch (IOException e) {
            e.printStackTrace();
        }
        //}
    }

    @RequestMapping("/getUserInfo")
    public void getUserInfo(HttpServletResponse response, HttpServletRequest request){
        //request.setCharacterEncoding("utf-8");
        String userName = request.getParameter("name");
        //String userName = request.getParameter("name");
        String email = request.getParameter("email");
        String phoneNumeber = request.getParameter("phoneNumeber");
        String address = request.getParameter("address");
        UserInfo user = new UserInfo();
        user.setUserName(userName);
        user.setEmail(email);
        user.setPhoneNumber(phoneNumeber);
        List<Object> list1 = new ArrayList<Object>() ;
        List<Object> list2 = new ArrayList<Object>();
        List<Object> list3 = new ArrayList<Object>();

        //Object[] param = {user.getUserName()};
        //List<User> userlist = new UserDaoImpl().select("SELECT * from userinfo where userName = ? ", param);
        UserInfo userInfo = userInfoDao.selectByUserName(userName);
        //List<Address> addresslist = new AddressDaoImpl().selectAddress("SELECT a.* from userinfo u,addressinfo a WHERE a.userId=u.userId AND u.userName = ?", param);
        List<AddressInfo> addressList = addressInfoDao.selectByUserId(userInfo.getUserId());
        //Object[] param4 = {userlist.get(0).getUserId()};
        //List<Order> orderlist = new OrderDaoImpl().select("SELECT DISTINCT i.*,s.orderStatus from orderinfo i, orderstatusinfo s where i.orderStatusId = s.orderStatusId and i.userId = ? ", param4);
        List<OrderInfo> orderList = orderInfoDao.selectByUserId(userInfo.getUserId());
        for (int i = 0; i < orderList.size(); i++) {
//            int i1=orderList.get(i).getOrderId();
//            int i2=orderList.get(i).getAddressInfo().getAddressId();
//            Object[] param1 = {i1};
//            Object[] param2 = {i2};
//
//            List<OrderItem> OrderItemlist = new OrderItemDaoImpl().select("SELECT * from orderitem where orderId = ?", param1);
//            List<Product> productlist = new ProductDaoImpl().select("SELECT p.* from productinfo p,orderinfo o,orderitem oo where o.orderId = oo.orderId AND oo.productId = p.productId and o.orderId =?",param1);
//            List<Address> addresslist1 = new AddressDaoImpl().selectAddress("SELECT * from addressinfo WHERE addressId= ?", param2);
            List<OrderItem> orderItemList = orderItemDao.selectByOrderId(orderList.get(i).getOrderId());
            List<ProductInfo> productList = productInfoDao.selectByOrderId(orderList.get(i).getOrderId());
            List<AddressInfo> addresslist1 = addressInfoDao.selectByAddressId(orderList.get(i).getAddressInfo().getAddressId());
            list1.add(addresslist1);
            list2.add(productList);
            list3.add(orderItemList);
        }
        request.getSession().setAttribute("list", userInfo);
        request.getSession().setAttribute("addresslist", addressList);
        request.getSession().setAttribute("orderList", orderList);
        request.getSession().setAttribute("list1", list1);
        request.getSession().setAttribute("list2",list2);
        request.getSession().setAttribute("list3",list3);

        // request.getRequestDispatcher("userInfo.jsp").forward(request, response);
        try {
            response.sendRedirect("userInfo.jsp");
        } catch (IOException e) {
            e.printStackTrace();
        }
        //response.getWriter().print(1);
    }

    @RequestMapping("updateAddress")
    public void updateAddress(HttpServletRequest request, HttpServletResponse response){
        //request.setCharacterEncoding("utf-8");
        String province = request.getParameter("province");
        String city = request.getParameter("city");
        String area = request.getParameter("area");
        String street = request.getParameter("street");
        String userName = request.getParameter("name");

        AddressInfo address = new AddressInfo();
        address .setProvince(province);
        address .setCity(city);
        address .setArea(area);
        address .setStreet(street);
        //UserInfo user = new UserInfo();
        //user.setUserName(userName);
        //Object[] param = {user.getUserName()};
        //List<User> userlist = new UserDaoImpl().select("SELECT u.userId FROM userinfo u where u.userName = ?", param);
        //Object[] param1 ={userlist.get(0).getUserId(),address.getProvince(),address.getCity(),address.getArea(),address.getStreet()};
        //Boolean boolean1 = new AddressDaoImpl().updateAddress("INSERT into addressinfo (userId, province, city, area, street) VALUES(?,?,?,?,?)", param1);
        int userId = userInfoDao.selectUserIdByUserName(userName);
        address.setUserId(userId);
        int result = addressInfoDao.insert(address);
        if (result > 0) {
            //List<Address> addresslist = new AddressDaoImpl().selectAddress("SELECT a.* from userinfo u,addressinfo a WHERE a.userId=u.userId AND u.userName = ?", param);
            List<AddressInfo> addressList = addressInfoDao.selectByUserId(userId);
            request.getSession().setAttribute("addresslist", addressList);
            try {
                response.getWriter().print(1);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    @RequestMapping("/updateUserInfo")
    public void updateUserInfo(HttpServletRequest request, HttpServletResponse response){
        //request.setCharacterEncoding("utf-8");
        String userName = request.getParameter("name");
        String email = request.getParameter("email");
        String phoneNumeber = request.getParameter("phoneNumeber");

        UserInfo user = new UserInfo();
        user.setUserName(userName);
        user.setEmail(email);
        user.setPhoneNumber(phoneNumeber);

       // Object[] param = { user.getEmail(), user.getPhoneNumber(), user.getUserName() };
        //Boolean boolean1 = new UserDaoImpl().update("UPDATE userinfo u SET u.email= ? ,u.phoneNumber= ? WHERE u.userName= ? ", param);
        int userId = userInfoDao.selectUserIdByUserName(userName);
        user.setUserId(userId);
        int result = userInfoDao.updateByPrimaryKeySelective(user);
        if (result > 0) {
            //Object[] param1 = { user.getUserName() };
            //List<User> userlist = new UserDaoImpl().select("SELECT * from userinfo where userName = ?", param1);
            UserInfo newUserInfo = userInfoDao.selectByUserName(userName);
            request.getSession().setAttribute("newUserInfo", newUserInfo);
            try {
                response.sendRedirect("userInfo.jsp");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
