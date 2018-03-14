package cn.qdu.dao;


import cn.qdu.entity.OrderStatusInfo;

public interface OrderStatusInfoDao {
    int deleteByPrimaryKey(Integer orderStatusId);

    int insert(OrderStatusInfo record);

    int insertSelective(OrderStatusInfo record);

    OrderStatusInfo selectByPrimaryKey(Integer orderStatusId);

    int updateByPrimaryKeySelective(OrderStatusInfo record);

    int updateByPrimaryKey(OrderStatusInfo record);
}