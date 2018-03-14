package cn.qdu.entity;

import org.springframework.beans.factory.annotation.Autowired;

public class ProductInfo {
    private Integer productId;

    private String productName;

    private Float productPrice;

    private Integer productInventory;

    private String productDetail;

    //private Integer productTypeId;
    @Autowired
    private ProductypeInfo productTypeInfo;
    
    public ProductypeInfo getProductTypeInfo() {
		return productTypeInfo;
	}

	public void setProductTypeInfo(ProductypeInfo productTypeInfo) {
		this.productTypeInfo = productTypeInfo;
	}

	private String defaultImg;

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName == null ? null : productName.trim();
    }

    public Float getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(Float productPrice) {
        this.productPrice = productPrice;
    }

    public Integer getProductInventory() {
        return productInventory;
    }

    public void setProductInventory(Integer productInventory) {
        this.productInventory = productInventory;
    }

    public String getProductDetail() {
        return productDetail;
    }

    public void setProductDetail(String productDetail) {
        this.productDetail = productDetail == null ? null : productDetail.trim();
    }


    public String getDefaultImg() {
        return defaultImg;
    }

    public void setDefaultImg(String defaultImg) {
        this.defaultImg = defaultImg == null ? null : defaultImg.trim();
    }
}