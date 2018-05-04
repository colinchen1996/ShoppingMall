package cn.qdu.dao;

import cn.qdu.entity.ProductypeInfo;

import java.util.List;

public interface ProductypeInfoDao {
    int deleteByPrimaryKey(Integer productTypeId);

    int insert(ProductypeInfo record);

    int insertSelective(ProductypeInfo record);

    ProductypeInfo selectByPrimaryKey(Integer productTypeId);

    int updateByPrimaryKeySelective(ProductypeInfo record);

    int updateByPrimaryKey(ProductypeInfo record);
    
    List<ProductypeInfo> selectAllProductType();//查询所有商品种类
    
    int selectProductType(ProductypeInfo productypeInfo);//根据商品种类或者商品种类id查询该商品种类或者id是否存在
    
    int selectProductTypeIdByType(String productType);

    String selectProductTypeByTypeId(Integer productTypeId);//根据商品类型id查找产品类型名称
    
    
}