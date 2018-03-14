package cn.qdu.dao;

import cn.qdu.entity.OrderInfo;

import java.util.List;


public interface OrderInfoDao {
    int deleteByPrimaryKey(Integer orderId);

    int insert(OrderInfo record);

    int insertSelective(OrderInfo record);

    OrderInfo selectByPrimaryKey(Integer orderId);

    int updateByPrimaryKeySelective(OrderInfo record);

    int updateByPrimaryKey(OrderInfo record);
    
    List<OrderInfo> selectOrders();
}