package cn.qdu.controller;

import cn.qdu.dao.ProductImgInfoDao;
import cn.qdu.dao.ProductInfoDao;
import cn.qdu.dao.ProductypeInfoDao;
import cn.qdu.entity.ProductImgInfo;
import cn.qdu.entity.ProductInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Controller
public class ProductController {

    @Autowired
    ProductInfoDao productInfoDao;
    @Autowired
    ProductImgInfoDao productImgInfoDao;
    @Autowired
    ProductypeInfoDao productypeInfoDao;

    @ResponseBody
    @RequestMapping("/getRecommendProduct")
    public List<ProductInfo> getRecommendProduct() {
        return productInfoDao.selectRecommendProduct();
    }

    @RequestMapping("/getProducts")
    public void getProducts(int productTypeId, HttpServletResponse response, HttpServletRequest request) {
        List<ProductInfo> productList = productInfoDao.selectProductByTypeId(productTypeId);
        String productType = productypeInfoDao.selectProductTypeByTypeId(productTypeId);
        request.setAttribute("productList", productList);
        request.setAttribute("productType", productType);
        try {
            request.getRequestDispatcher("products.jsp").forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("/getProductDetail")
    public void getProductDetail(int idd, HttpServletRequest request, HttpServletResponse response) {
        ProductInfo productInfo = productInfoDao.selectByPrimaryKey(idd);
        List<ProductInfo> sameTypeProductList = productInfoDao.selectSameTypeProduct(idd);
        List<ProductImgInfo> productImgInfoList = productImgInfoDao.selectByProductId(idd);

        String listIdCookieValue = "";
        //从客户端获取cookie集合，遍历cookie集合
        Cookie[] cookies = request.getCookies();
        if (null != cookies && cookies.length > 0) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("ListIdCookie")) {
                    listIdCookieValue = cookie.getValue();
                }
            }
        }
        //以逗号进行分隔
        listIdCookieValue += idd + "，";
        //如果cookie中的记录过多，则清零
        String[] arr = listIdCookieValue.split("，");
        List<ProductInfo> historyProductList = new ArrayList();
        if (arr != null && arr.length > 0) {
            if (arr.length >= 50) {
                listIdCookieValue = "";
            }
            for (String s : arr) {
                historyProductList.add(productInfoDao.selectByPrimaryKey(Integer.parseInt(s)));

            }
        }
        Cookie newCookie = new Cookie("ListIdCookie", listIdCookieValue);
        //设置cookie的有效期
        newCookie.setMaxAge(24 * 60 * 60);
        response.addCookie(newCookie);

        request.setAttribute("productInfo", productInfo);
        request.setAttribute("sameTypeProductList", sameTypeProductList);
        request.setAttribute("historyProductList", historyProductList);
        request.setAttribute("productImgInfoList", productImgInfoList);
        try {
            request.getRequestDispatcher("product_detail.jsp").forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
