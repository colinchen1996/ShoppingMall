package cn.qdu.dao;


import cn.qdu.entity.OrderItem;

public interface OrderItemDao {
    int insert(OrderItem record);

    int insertSelective(OrderItem record);
}