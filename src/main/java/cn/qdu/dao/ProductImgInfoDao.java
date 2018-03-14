package cn.qdu.dao;


import cn.qdu.entity.ProductImgInfo;

public interface ProductImgInfoDao {
    int insert(ProductImgInfo record);

    int insertSelective(ProductImgInfo record);
}