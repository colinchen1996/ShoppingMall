package cn.qdu.service.impl;

import cn.qdu.dao.UserInfoDao;
import cn.qdu.entity.UserInfo;
import cn.qdu.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class UserServiceImpl implements UserService {
    @Autowired
    UserInfoDao userInfoDao;

    public boolean register(UserInfo user) {
        //boolean ch=update("insert into userinfo(userName,userPass,email,phoneNumber) values (?,?,?,?)", new Object[]{user.getUserName(),user.getUserPass(),user.getEmail(),user.getPhoneNumber()});
        return userInfoDao.insertSelective(user) > 0 ? true : false;
    }

    public String login(UserInfo userInfo) {
        UserInfo user= userInfoDao.findByNameAndPassword(userInfo);
        if(user == null){
            return "false";
        }else if("已锁定".equals(user.getUserStatus())){
            return "已锁定";
        }else if("admin".equals(user.getUserName())){
            return "admin";
        }else{
            return "true";
        }
    }

    public boolean registerCheck(UserInfo user) {
        return false;
    }
}
