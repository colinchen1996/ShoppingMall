package cn.qdu.controller;

import cn.qdu.entity.OrderInfo;
import cn.qdu.entity.ProductInfo;
import cn.qdu.entity.ProductypeInfo;
import cn.qdu.entity.UserInfo;
import cn.qdu.service.ManagementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ManagementController {
	@Autowired
	ManagementService managementServiceImpl;

	@RequestMapping("Index")
	public String index(){
		return "management";
	} 
	
	@ResponseBody
	@RequestMapping("SearchProductType")
	public Object searchProductType() {
		List<ProductypeInfo> list = managementServiceImpl.selectAllProductType();
		return list;
	}

	@ResponseBody
	@RequestMapping("InsertProductType")
	public String insertProductType(ProductypeInfo productypeInfo) {
		if (productypeInfo.getProductTypeId() != null && productypeInfo.getProductType() != null) {
			if (managementServiceImpl.selectProductType(productypeInfo)) {
				managementServiceImpl.insertProductType(productypeInfo);
				return "true";
			} else {
				return "false";
			}
		} else {
			return "false";
		}
	}

	@RequestMapping("DeleteProductType")
	public String deleteProductType(int productTypeId) {
		managementServiceImpl.deleteProductType(productTypeId);
		return null;
	}

	@ResponseBody
	@RequestMapping("SearchProduct")
	public Object searchProduct(int currPage) {
		int count = managementServiceImpl.selectProductCount();
		int pageSize=5;
		List<ProductInfo> list =  managementServiceImpl.selectProductByPage(currPage,pageSize);
		Map<String,Object> map = new HashMap();
		map.put("p", count);
		map.put("l", list);
		return map;
	}

	@RequestMapping("DeleteProduct")
	public String deleteProduct(int productId) {
		managementServiceImpl.deleteProduct(productId);
		return null;
	}

	@ResponseBody
	@RequestMapping("InsertProduct")
	public String insertProduct(ProductInfo productInfo,ProductypeInfo productTypeInfo) {
		if (productInfo.getProductId()!=null && productInfo.getProductName()!=null && productInfo.getProductPrice()!=null
				&& productInfo.getProductInventory()!=null && productInfo.getProductDetail()!=null && productTypeInfo.getProductType()!=null
				&& productInfo.getDefaultImg()!=null) {
			// 根据商品类型查出商品类型id
			int productTypeId = managementServiceImpl.selectProductTypeIdByType(productTypeInfo.getProductType());
			productTypeInfo.setProductTypeId(productTypeId);
			productInfo.setProductTypeInfo(productTypeInfo);
			// 查询是否存在重复商品
			if (!managementServiceImpl.selectProductIfExist(productInfo)) {
				//修改商品 图片后缀名
				productInfo.setDefaultImg(productInfo.getDefaultImg().substring(productInfo.getDefaultImg().lastIndexOf("\\")+1));
				int b = managementServiceImpl.insertProduct(productInfo);
				if (b >0) {
					return "true";
				} else {
					return "false";
				}
			} else {
				return "false";
			}
		} else {
			return "false";
		}
	}

	@ResponseBody
	@RequestMapping("UpdateProductInventory")
	public String updateProductInventory(int productId,int productInventory) {
		int b = managementServiceImpl.changeInventory(productId,productInventory);
		if (b>0) {
			return "true";
		} else {
			return "false";
		}
	}

	@ResponseBody
	@RequestMapping("UpdateProductPrice")
	public String updateProductPrice(int productId,float productPrice) {
		 int b=managementServiceImpl.changePrice(productId, productPrice);
		if (b>0) {
			return "true";
		} else {
			return "false";
		}
	}

	@ResponseBody
	@RequestMapping("ManageOrderinfo")
	public Object manageOrderinfo(){
		List<OrderInfo> orders = managementServiceImpl.selectOrders();
		return orders;
	}

	@ResponseBody
	@RequestMapping("ManageUserInfo")
	public Object manageUserInfo() {
		List<UserInfo> userList= managementServiceImpl.selectAllUser();
		return userList;
	}

	@ResponseBody
	@RequestMapping("LockUser")
	public String lockUser(UserInfo userInfo) {
		boolean b;
		if ("已锁定".equals(userInfo.getUserStatus())) {
			userInfo.setUserStatus("未锁定");
			managementServiceImpl.lockUser(userInfo);
			return "未锁定";
		} else {
			userInfo.setUserStatus("已锁定");
			managementServiceImpl.lockUser(userInfo);
			return "已锁定";
		}
	}
}
