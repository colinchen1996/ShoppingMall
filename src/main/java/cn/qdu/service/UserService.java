package cn.qdu.service;

import cn.qdu.entity.UserInfo;

public interface UserService {
    boolean register(UserInfo user);

    String login(UserInfo user);

    boolean registerCheck(UserInfo user);
}
