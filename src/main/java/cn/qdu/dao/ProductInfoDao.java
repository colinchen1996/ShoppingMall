package cn.qdu.dao;


import cn.qdu.entity.ProductInfo;

import java.util.List;

public interface ProductInfoDao {
    int deleteByPrimaryKey(Integer productId);

    int insert(ProductInfo record);

    int insertSelective(ProductInfo record);

    ProductInfo selectByPrimaryKey(Integer productId);

    int updateByPrimaryKeySelective(ProductInfo record);

    int updateByPrimaryKey(ProductInfo record);
    
    int selectProductCount();
    
    List<ProductInfo> selectProductByPage(int startNum, int pageSize);
    
    int selectProduct(ProductInfo productInfo);
    
    int updateInventory(int productId, int productInventory);//更新商品库存
    
    int updatePrice(int productId, float productPrice);//更新商品价格

    List<ProductInfo> selectProductByTypeId(Integer productTypeId);

    List<ProductInfo> selectByOrderId(Integer orderId);

    List<ProductInfo> selectRecommendProduct();

    List<ProductInfo> selectSameTypeProduct(int productId);
}