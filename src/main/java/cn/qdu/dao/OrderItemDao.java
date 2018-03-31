package cn.qdu.dao;


import cn.qdu.entity.OrderItem;

import java.util.List;

public interface OrderItemDao {
    int insert(OrderItem record);

    int insertSelective(OrderItem record);

    List<OrderItem> selectByOrderId(Integer orderId);
}