package cn.qdu.dao;


import cn.qdu.entity.ProductImgInfo;

import java.util.List;

public interface ProductImgInfoDao {
    int insert(ProductImgInfo record);

    int insertSelective(ProductImgInfo record);

    List<ProductImgInfo> selectByProductId(int productId);
}