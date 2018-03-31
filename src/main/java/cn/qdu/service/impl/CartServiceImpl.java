package cn.qdu.service.impl;

import cn.qdu.dao.ProductInfoDao;
import cn.qdu.entity.ProductInfo;
import cn.qdu.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CartServiceImpl  implements CartService {

    @Autowired
    ProductInfoDao productInfoDao;

    @Override
    public ProductInfo getProductById(int productId) {
        return productInfoDao.selectByPrimaryKey(productId);
    }
}
