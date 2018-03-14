package cn.qdu.entity;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

public class OrderInfo {
    private Integer orderId;

    private String orderDate;

    private Float orderPrice;

   // private Integer orderStatusId;
    @Autowired
    private OrderStatusInfo orderStatusInfo;
    //private Integer userId;
    @Autowired
    private UserInfo userInfo;
    //private Integer addressId;
    @Autowired
    private AddressInfo addressInfo;
    
    private List<OrderItem> orderItemList; 
    
    public List<OrderItem> getOrderItemList() {
		return orderItemList;
	}

	public void setOrderItemList(List<OrderItem> orderItemList) {
		this.orderItemList = orderItemList;
	}

	public OrderStatusInfo getOrderStatusInfo() {
		return orderStatusInfo;
	}

	public void setOrderStatusInfo(OrderStatusInfo orderStatusInfo) {
		this.orderStatusInfo = orderStatusInfo;
	}

	public UserInfo getUserInfo() {
		return userInfo;
	}

	public void setUserInfo(UserInfo userInfo) {
		this.userInfo = userInfo;
	}

	public AddressInfo getAddressInfo() {
		return addressInfo;
	}

	public void setAddressInfo(AddressInfo addressInfo) {
		this.addressInfo = addressInfo;
	}

	public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate == null ? null : orderDate.trim();
    }

    public Float getOrderPrice() {
        return orderPrice;
    }

    public void setOrderPrice(Float orderPrice) {
        this.orderPrice = orderPrice;
    }

    
}