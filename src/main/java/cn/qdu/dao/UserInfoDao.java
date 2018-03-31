package cn.qdu.dao;


import cn.qdu.entity.UserInfo;

import java.util.List;

public interface UserInfoDao {
    int deleteByPrimaryKey(Integer userId);

    int insert(UserInfo record);

    int insertSelective(UserInfo record);

    UserInfo selectByPrimaryKey(Integer userId);

    int updateByPrimaryKeySelective(UserInfo record);

    int updateByPrimaryKey(UserInfo record);

    List<UserInfo> selectAllUser();

    UserInfo findByNameAndPassword(UserInfo userInfo);

    UserInfo selectByUserName(String name);

    UserInfo selectByUserNameOrEmailOrPhoneNumber(UserInfo userInfo);

    int selectUserIdByUserName(String userName);
}