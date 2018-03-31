package cn.qdu.dao;


import cn.qdu.entity.AddressInfo;

import java.util.List;

public interface AddressInfoDao {
    int deleteByPrimaryKey(Integer addressId);

    int insert(AddressInfo record);

    int insertSelective(AddressInfo record);

    AddressInfo selectByPrimaryKey(Integer addressId);

    int updateByPrimaryKeySelective(AddressInfo record);

    int updateByPrimaryKey(AddressInfo record);

    List<AddressInfo> selectByUserId(Integer userId);

    List<AddressInfo> selectByAddressId(Integer addressId);
}