package cn.qdu.service;

import cn.qdu.entity.OrderInfo;
import cn.qdu.entity.ProductInfo;
import cn.qdu.entity.ProductypeInfo;
import cn.qdu.entity.UserInfo;

import java.util.List;


public interface ManagementService {
	List<ProductypeInfo> selectAllProductType();
	
	boolean selectProductType(ProductypeInfo productypeInfo);//根据商品种类或者商品种类id查询该商品种类或者id是否存在

	int selectProductTypeIdByType(String productType);//根据商品类型查出商品类型id
	
	void insertProductType(ProductypeInfo productypeInfo);

	void deleteProductType(int productTypeId);
	
	int selectProductCount(); //查询商品的总数
	
	List<ProductInfo> selectProductByPage(int pageNum, int pageSize);
	
	int deleteProduct(int productId);
	
	boolean selectProductIfExist(ProductInfo productInfo);//根据商品id或商品名查询该商品是否已经存在
	
	int insertProduct(ProductInfo productInfo);//插入商品信息
	
	int changeInventory(int productId, int productInventory);//修改商品库存
	
	int changePrice(int productId, float productPrice);//更新商品价格
	
	List<OrderInfo> selectOrders();//查询订单信息
	
	List<UserInfo> selectAllUser();//查询所有用户信息
	
	boolean lockUser(UserInfo userInfo);//锁定用户
	
}
