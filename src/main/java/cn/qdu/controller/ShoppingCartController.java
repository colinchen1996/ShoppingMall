package cn.qdu.controller;

import cn.qdu.entity.ProductInfo;
import cn.qdu.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Controller
public class ShoppingCartController {

    @Autowired
    CartService cartService;

    @ResponseBody
    @RequestMapping("/addCart")
    public int addCart(HttpServletRequest request) throws IOException {
        if (request.getSession().getAttribute("productIdAndCount") == null) {
            Map<Integer, Integer> productIdAndCount = new HashMap();
            int productId = Integer.parseInt(request.getParameter("productId"));
            int count = Integer.parseInt(request.getParameter("count"));
            productIdAndCount.put(productId, count);
            request.getSession().setAttribute("productIdAndCount", productIdAndCount);
            return productIdAndCount.size();
        } else {
            Map<Integer, Integer> productIdAndCount = (HashMap<Integer, Integer>) request.getSession().getAttribute("productIdAndCount");
            int productId = Integer.parseInt(request.getParameter("productId"));
            int count = Integer.parseInt(request.getParameter("count"));
            if (productIdAndCount.get(productId) != null) {
                productIdAndCount.put(productId, productIdAndCount.get(productId).intValue() + count);
            } else {
                productIdAndCount.put(productId, count);
            }
            request.getSession().setAttribute("productIdAndCount", productIdAndCount);
            return productIdAndCount.size();
        }
    }

    /**
     * 获得购物车小图标上的物品数量
     *
     * @param request
     */
    @ResponseBody
    @RequestMapping("/getCartCount")
    public int getCartCount(HttpServletRequest request) {
        Map<Integer, Integer> productIdAndCount = (HashMap<Integer, Integer>) request.getSession().getAttribute("productIdAndCount");
        if (productIdAndCount != null) {
            return productIdAndCount.size();
        } else {
            return 0;
        }
    }

    /**
     * 购物车页面物品显示
     *
     * @param response
     * @param request
     */
    @RequestMapping("/countCart")
    public void countCart(HttpServletResponse response, HttpServletRequest request) {
        Map<Integer, Integer> productIdAndCount = (HashMap<Integer, Integer>) request.getSession().getAttribute("productIdAndCount");
        Map<ProductInfo, Integer> productInfoAndCount = new HashMap();
        if (productIdAndCount != null && !productIdAndCount.isEmpty()) {
            for (Integer productId : productIdAndCount.keySet()) {
                ProductInfo productInfo = cartService.getProductById(productId);
                Integer count = productIdAndCount.get(productId);
                productInfoAndCount.put(productInfo, count);
            }
        }
        request.getSession().setAttribute("productInfoAndCount", productInfoAndCount);
        try {
            request.getRequestDispatcher("product_checkout.jsp").forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    @ResponseBody
    @RequestMapping("/deleteCart")
    public int deleteCart(HttpServletRequest request) {
        Map<Integer, Integer> productIdAndCount = (HashMap<Integer, Integer>) request.getSession().getAttribute("productIdAndCount");
        int deleteId = Integer.parseInt(request.getParameter("deleteProductId"));
        productIdAndCount.remove(deleteId);
        request.getSession().setAttribute("productIdAndCount", productIdAndCount);
        return productIdAndCount.size();
    }
}
