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
import java.util.*;

@Controller
public class ShoppingCartController {

    @Autowired
    CartService cartService;

    @ResponseBody
    @RequestMapping("/addCart")
    public int addCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        if ("add".equals(request.getParameter("action"))) {
            if (request.getSession().getAttribute("productMap") == null) {
                Map productMap = new HashMap();
                int productId = Integer.parseInt(request.getParameter("productId"));
                int count = Integer.parseInt(request.getParameter("count"));
                //	request.getSession().setAttribute("count",count);
                productMap.put(productId, count);
                request.getSession().setAttribute("productMap", productMap);
                request.getSession().setAttribute("count", count);
                //response.getWriter().print(count);
                return count;
            } else {
                Map productMap = (HashMap) request.getSession().getAttribute("productMap");
                int productId = Integer.parseInt(request.getParameter("productId"));
                int count = Integer.parseInt(request.getParameter("count"));
                Iterator iter = productMap.entrySet().iterator();
                while (iter.hasNext()) {
                    Map.Entry entry = (Map.Entry) iter.next();
                    if (productId == (Integer) entry.getKey()) {
                        count = (Integer) entry.getKey() + 1;
                    }
                }
                productMap.put(productId, count);
                request.getSession().setAttribute("productMap", productMap);
                request.getSession().setAttribute("count", count);
                //response.getWriter().print(count);
                return count;
            }
        } else if ("totalcount".equals(request.getParameter("action"))) {
            if (request.getSession().getAttribute("productMap") != null) {
                Map productMap = (HashMap) request.getSession().getAttribute("productMap");
                int totalcount = 0;
                Iterator iter = productMap.entrySet().iterator();
                while (iter.hasNext()) {
                    Map.Entry entry = (Map.Entry) iter.next();
                    totalcount += (Integer) entry.getValue();
                }
                //response.getWriter().print(totlecount);
                return totalcount;
            } else {
                int totalcount = 0;
                //response.getWriter().print(totlecount);
                return totalcount;
            }
        } else {
            return 0;
        }
        //request.getSession().setAttribute("productMap", productMap);
        //HashMap productMap = new HashMap();
        //CartDaoImpl cartDaoImpl = new CartDaoImpl();
//		Iterator iter = productMap.entrySet().iterator();
//		Map.Entry entry = (Map.Entry) iter.next();
//		if ((int)entry.getKey() == 1) {
//		}
    }

    @RequestMapping("/countCart")
    public void countCart(HttpServletResponse response, HttpServletRequest request) {
        Map productMap = (HashMap) request.getSession().getAttribute("productMap");

        List<ProductInfo> list = new ArrayList<ProductInfo>();
        List countlist = new ArrayList();
        if (productMap != null) {
            Iterator iter = productMap.entrySet().iterator();
            while (iter.hasNext()) {
                Map.Entry entry = (Map.Entry) iter.next();
                int productId = (Integer) entry.getKey();
                int count = (Integer) entry.getValue();
                countlist.add(count);
                ProductInfo productInfo = cartService.getProductById(productId);
                list.add(productInfo);
            }
        }
        request.setAttribute("list", list);
        request.setAttribute("countlist", countlist);
        try {
            request.getRequestDispatcher("product_checkout.jsp").forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    @RequestMapping("/deleteCart")
    public void deleteCart(HttpServletRequest request) {
        if (request.getSession().getAttribute("productMap") == null) {
        } else {
            Map productMap = (HashMap) request.getSession().getAttribute("productMap");
            int deleteId = Integer.parseInt(request.getParameter("deleteProductId"));
            productMap.remove(deleteId);
            request.getSession().setAttribute("productMap", productMap);
        }
    }
}
