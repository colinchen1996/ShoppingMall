package cn.qdu.dao;


import cn.qdu.entity.CartInfo;

public interface CartInfoDao {
    int deleteByPrimaryKey(Integer cartId);

    int insert(CartInfo record);

    int insertSelective(CartInfo record);

    CartInfo selectByPrimaryKey(Integer cartId);

    int updateByPrimaryKeySelective(CartInfo record);

    int updateByPrimaryKey(CartInfo record);
}