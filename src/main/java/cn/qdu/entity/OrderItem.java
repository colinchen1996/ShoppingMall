package cn.qdu.entity;

import org.springframework.beans.factory.annotation.Autowired;

public class OrderItem {
    private Integer orderId;
	
	private OrderInfo orderInfo;
	
    //private Integer productId;
    @Autowired
    private ProductInfo productInfo;
    
    private Integer productCount;

    
    public OrderInfo getOrderInfo() {
		return orderInfo;
	}

	public void setOrderInfo(OrderInfo orderInfo) {
		this.orderInfo = orderInfo;
	}

    public Integer getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}

	public ProductInfo getProductInfo() {
		return productInfo;
	}

	public void setProductInfo(ProductInfo productInfo) {
		this.productInfo = productInfo;
	}

	public Integer getProductCount() {
        return productCount;
    }

    public void setProductCount(Integer productCount) {
        this.productCount = productCount;
    }
}