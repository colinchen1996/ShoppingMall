package cn.qdu.controller;

import cn.qdu.dao.ProductImgInfoDao;
import cn.qdu.dao.ProductInfoDao;
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

    @ResponseBody
    @RequestMapping("/getRecommendProduct")
    public List<ProductInfo> getRecommendProduct(HttpServletResponse response){
        //ProductDaoImpl productDapInmpl = new ProductDaoImpl();
        //List<Product> allList = productDapInmpl.selectAll();
        //request.setAttribute("allList", allList);
        //request.getRequestDispatcher("index.jsp").forward(request, response);
        //List<ProductInfo> allList =
        return productInfoDao.selectRecommendProduct();
        //JSONArray array=JSONArray.fromObject(allList);
        //response.getWriter().print(array);
    }

    @RequestMapping("/getFresh")
    public void getFresh(HttpServletResponse response, HttpServletRequest request){
        //ProductDaoImpl productDapInmpl = new ProductDaoImpl();
        //List<ProductInfo> freshList = productDapInmpl.selectFresh();
        List<ProductInfo> freshList = productInfoDao.selectProductByTypeId(3);
        request.setAttribute("freshList", freshList);
        try {
            request.getRequestDispatcher("fresh.jsp").forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("/getFruit")
    public void getFruit(HttpServletResponse response, HttpServletRequest request){
        //ProductDaoImpl productDapInmpl = new ProductDaoImpl();
        //List<ProductInfo> freshList = productDapInmpl.selectFresh();
        List<ProductInfo> fruitList = productInfoDao.selectProductByTypeId(1);
        request.setAttribute("fruitList", fruitList);
        try {
            request.getRequestDispatcher("fruit.jsp").forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("/getVegetables")
    public void getVegetables(HttpServletResponse response, HttpServletRequest request){
        //ProductDaoImpl productDapInmpl = new ProductDaoImpl();
        //List<ProductInfo> freshList = productDapInmpl.selectFresh();
        List<ProductInfo> vegetablesList = productInfoDao.selectProductByTypeId(2);
        request.setAttribute("vegetablesList", vegetablesList);
        try {
            request.getRequestDispatcher("vegetables.jsp").forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("/getProductDetail")
    public void getProductDetail(HttpServletRequest request, HttpServletResponse response){
        String id = request.getParameter("idd");
        int id1= (id == null) ? 1 :Integer.parseInt(id);
        ProductInfo product = new ProductInfo();
        product.setProductId(id1);
        //ProductDaoImpl productDapInmpl = new ProductDaoImpl();
        //List<ProductInfo> productsList = productDapInmpl.selectId(product);
        ProductInfo productInfo = productInfoDao.selectByPrimaryKey(id1);
        //List<Product> productsList1 = productDapInmpl.selectType(product);
        List<ProductInfo> productsList1 = productInfoDao.selectSameTypeProduct(id1);
        ProductImgInfo productImgInfo = new ProductImgInfo();
        productImgInfo.setProductId(id1);
        //ProductImgInfoDaoImpl productImgInfoDaoImpl = new ProductImgInfoDaoImpl();
        //List<ProductImgInfo> productImgInfoList = productImgInfoDaoImpl.selectImgInfo(productImgInfo);
        List<ProductImgInfo> productImgInfoList = productImgInfoDao.selectByProductId(id1);

        String list0 = "";
        //从客户端获取cookie集合，遍历cookie集合
        Cookie[] cookies = request.getCookies();
        if(null != cookies && cookies.length > 0){
            for(Cookie cookie : cookies){
                if(cookie.getName().equals("ListIdCookie")){
                    list0 = cookie.getValue();
                }
            }
        }
        //以逗号进行分隔
        list0 += id + ",";
        //如果cookie中的记录过多，则清零
        String[] arr = list0.split(",");
        List<ProductInfo> productsList3=new ArrayList<ProductInfo>();
        if(arr != null && arr.length > 0){
            if(arr.length >= 50){
                list0 = "";
            }
            int id2;
            for(String s : arr){
                id2 = Integer.parseInt(s);
                productsList3.add(productInfoDao.selectByPrimaryKey(id2));

            }
        }

        Cookie newCookie = new Cookie("ListIdCookie",list0);
        //设置cookie的有效期
        newCookie.setMaxAge(24*60*60);

        response.addCookie(newCookie);

        request.setAttribute("productsList", productInfo);
        request.setAttribute("productsList1", productsList1);
        request.setAttribute("productsList3", productsList3);
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
