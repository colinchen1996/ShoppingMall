package cn.qdu.service.impl;

import java.util.List;

import cn.qdu.dao.OrderInfoDao;
import cn.qdu.dao.ProductInfoDao;
import cn.qdu.dao.ProductypeInfoDao;
import cn.qdu.dao.UserInfoDao;
import cn.qdu.entity.OrderInfo;
import cn.qdu.entity.ProductInfo;
import cn.qdu.entity.ProductypeInfo;
import cn.qdu.entity.UserInfo;
import cn.qdu.service.ManagementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ManagementServiceImpl implements ManagementService {
	@Autowired
	ProductypeInfoDao productypeInfoDao;
	@Autowired
	UserInfoDao userInfoDao;
	@Autowired
	ProductInfoDao productInfoDao;
	@Autowired
	OrderInfoDao orderInfoDao;

	@Override
	public List<ProductypeInfo> selectAllProductType() {
		return productypeInfoDao.selectAllProductType();
	}

	@Override
	public boolean selectProductType(ProductypeInfo productypeInfo) {
		if (productypeInfoDao.selectProductType(productypeInfo) > 0) {
			return false;
		} else {
			return true;
		}
	}
	
	@Override
	public int selectProductTypeIdByType(String productType) {
		return productypeInfoDao.selectProductTypeIdByType(productType);
	}

	
	@Override
	public void insertProductType(ProductypeInfo productypeInfo) {
		productypeInfoDao.insert(productypeInfo);
	}

	@Override
	public void deleteProductType(int productTypeId) {
		productypeInfoDao.deleteByPrimaryKey(productTypeId);
	}

	@Override
	public int selectProductCount() {
		return productInfoDao.selectProductCount();
	}

	@Override
	public List<ProductInfo> selectProductByPage(int pageNum, int pageSize) {
		return productInfoDao.selectProductByPage((pageNum-1)*pageSize, pageSize);
	}

	@Override
	public int deleteProduct(int productId) {
		return productInfoDao.deleteByPrimaryKey(productId);
	}

	@Override
	public boolean selectProductIfExist(ProductInfo productInfo) {
		if(productInfoDao.selectProduct(productInfo)>0){
			return true;
		}else{
			return false;
		}
	}

	@Override
	public int insertProduct(ProductInfo productInfo) {
		return productInfoDao.insert(productInfo);
	}

	@Override
	public int changeInventory(int productId, int productInventory) {

		return productInfoDao.updateInventory(productId, productInventory);
	}

	@Override
	public int changePrice(int productId, float productPrice) {
		return productInfoDao.updatePrice(productId, productPrice);
	}

	@Override
	public List<OrderInfo> selectOrders() {
		return orderInfoDao.selectOrders();
	}


	@Override
	public List<UserInfo> selectAllUser() {
		return userInfoDao.selectAllUser();
	}

	@Override
	public boolean lockUser(UserInfo userInfo) {
		if(userInfoDao.updateByPrimaryKeySelective(userInfo)>0){
			return true;
		}else{
			return false;
		}
	}

	
}
