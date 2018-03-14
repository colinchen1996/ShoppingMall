package cn.qdu.dao;


import cn.qdu.entity.AddressInfo;

public interface AddressInfoDao {
    int deleteByPrimaryKey(Integer addressId);

    int insert(AddressInfo record);

    int insertSelective(AddressInfo record);

    AddressInfo selectByPrimaryKey(Integer addressId);

    int updateByPrimaryKeySelective(AddressInfo record);

    int updateByPrimaryKey(AddressInfo record);
}